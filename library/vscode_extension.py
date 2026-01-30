#!/usr/bin/python
# -*- coding: utf-8 -*-

from __future__ import absolute_import, division, print_function
__metaclass__ = type

DOCUMENTATION = r'''
---
module: vscode_extension
short_description: Manage VS Code extensions via `code` CLI
description:
  - Installs/uninstalls VS Code extensions using the `code` command.
  - Ensures idempotency by checking installed extensions first.
options:
  name:
    description:
      - Extension identifier, e.g. C(ms-python.python) or with version C(ms-python.python@2024.0.0).
    type: str
    required: true
  state:
    description:
      - Desired state of the extension.
    type: str
    choices: [present, absent]
    default: present
  code_path:
    description:
      - Path to VS Code CLI executable (C(code)). If omitted, searches in PATH.
    type: str
    required: false
  user_data_dir:
    description:
      - VS Code user-data-dir to target a specific profile directory.
    type: str
    required: false
  extensions_dir:
    description:
      - VS Code extensions-dir to target a specific extensions directory.
    type: str
    required: false
  force:
    description:
      - Pass C(--force) on install.
    type: bool
    default: false
author:
  - PocketSign Inc.
'''

EXAMPLES = r'''
- name: Install Python extension
  vscode_extension:
    name: ms-python.python
    state: present

- name: Install a specific version (requires CLI support)
  vscode_extension:
    name: ms-python.python@2024.0.0
    state: present

- name: Uninstall an extension
  vscode_extension:
    name: ms-python.python
    state: absent

- name: Use custom VS Code CLI path and directories
  vscode_extension:
    name: ms-python.python
    state: present
    code_path: /usr/bin/code
    user_data_dir: /home/ubuntu/.config/Code
    extensions_dir: /home/ubuntu/.vscode/extensions
'''

RETURN = r'''
changed:
  description: Whether anything was changed.
  type: bool
installed:
  description: Installed extensions (optionally with versions if available).
  type: list
  elements: str
stdout:
  description: Raw stdout from the last CLI call (if any).
  type: str
stderr:
  description: Raw stderr from the last CLI call (if any).
  type: str
'''

from ansible.module_utils.basic import AnsibleModule
import shutil
import re


def _parse_name_and_version(name: str):
    """
    Accept:
      - publisher.ext
      - publisher.ext@1.2.3
    """
    if "@" in name:
        base, ver = name.split("@", 1)
        base = base.strip()
        ver = ver.strip()
        return base, ver
    return name.strip(), None


def _build_base_args(module, code_cmd):
    args = [code_cmd]
    user_data_dir = module.params.get("user_data_dir")
    extensions_dir = module.params.get("extensions_dir")
    if user_data_dir:
        args += ["--user-data-dir", user_data_dir]
    if extensions_dir:
        args += ["--extensions-dir", extensions_dir]
    return args


def _run(module, args):
    rc, out, err = module.run_command(args)
    return rc, out, err


def _list_extensions(module, code_cmd):
    """
    Prefer versions if supported:
      code --list-extensions --show-versions
    Fallback to:
      code --list-extensions
    Returns:
      installed_map: { "publisher.ext": "1.2.3" or None }
      raw_list: list[str] (lines)
    """
    base = _build_base_args(module, code_cmd)

    # Try with versions
    rc, out, err = _run(module, base + ["--list-extensions", "--show-versions"])
    if rc == 0:
        lines = [l.strip() for l in out.splitlines() if l.strip()]
        installed = {}
        # expected lines like: publisher.ext@1.2.3
        for l in lines:
            if "@" in l:
                n, v = l.split("@", 1)
                installed[n.strip()] = v.strip()
            else:
                installed[l] = None
        return installed, lines, out, err

    # Fallback without versions
    rc2, out2, err2 = _run(module, base + ["--list-extensions"])
    if rc2 != 0:
        module.fail_json(msg="Failed to list VS Code extensions. Is `code` available and usable?",
                         rc=rc2, stdout=out2, stderr=err2)
    lines = [l.strip() for l in out2.splitlines() if l.strip()]
    installed = {l: None for l in lines}
    return installed, lines, out2, err2


def main():
    module = AnsibleModule(
        argument_spec=dict(
            name=dict(type="str", required=True),
            state=dict(type="str", choices=["present", "absent"], default="present"),
            code_path=dict(type="str", required=False, default=None),
            user_data_dir=dict(type="str", required=False, default=None),
            extensions_dir=dict(type="str", required=False, default=None),
            force=dict(type="bool", default=False),
        ),
        supports_check_mode=True,
    )

    name_in = module.params["name"]
    state = module.params["state"]
    force = module.params["force"]

    ext_name, desired_ver = _parse_name_and_version(name_in)

    code_cmd = module.params.get("code_path") or shutil.which("code")
    if not code_cmd:
        module.fail_json(msg="`code` command not found. Install VS Code or set code_path.")

    installed_map, raw_lines, list_stdout, list_stderr = _list_extensions(module, code_cmd)

    is_installed = ext_name in installed_map
    installed_ver = installed_map.get(ext_name)

    # Determine if change needed
    changed = False
    action = None

    if state == "present":
        if not is_installed:
            changed = True
            action = "install"
        elif desired_ver is not None and installed_ver is not None and desired_ver != installed_ver:
            # version mismatch (only possible when --show-versions worked)
            changed = True
            action = "install"
        elif desired_ver is not None and installed_ver is None:
            # Can't verify version; still attempt install to satisfy version request
            changed = True
            action = "install"

    elif state == "absent":
        if is_installed:
            changed = True
            action = "uninstall"

    # check_mode
    if module.check_mode:
        module.exit_json(
            changed=changed,
            installed=raw_lines,
            stdout=list_stdout,
            stderr=list_stderr,
            msg=("Would %s %s" % (action, ext_name)) if action else "No change needed",
        )

    last_out = list_stdout
    last_err = list_stderr

    if action == "install":
        base = _build_base_args(module, code_cmd)
        cmd = base + ["--install-extension", name_in]
        if force:
            cmd.append("--force")
        rc, out, err = _run(module, cmd)
        last_out, last_err = out, err
        if rc != 0:
            module.fail_json(msg=f"Failed to install extension: {name_in}", rc=rc, stdout=out, stderr=err)

    elif action == "uninstall":
        base = _build_base_args(module, code_cmd)
        cmd = base + ["--uninstall-extension", ext_name]
        rc, out, err = _run(module, cmd)
        last_out, last_err = out, err
        if rc != 0:
            module.fail_json(msg=f"Failed to uninstall extension: {ext_name}", rc=rc, stdout=out, stderr=err)

    # Re-list to return current state
    installed_map2, raw_lines2, out2, err2 = _list_extensions(module, code_cmd)

    module.exit_json(
        changed=changed,
        installed=raw_lines2,
        stdout=last_out,
        stderr=last_err,
        msg="OK",
    )


if __name__ == "__main__":
    main()
