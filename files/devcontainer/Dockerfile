FROM archlinux/base

RUN curl https://www.archlinux.org/mirrorlist/?country=JP | sed -e s/#S/S/g -e /^#/d -e /^$/d | sort -rn > /etc/pacman.d/mirrorlist && \
    pacman -Syu --noconfirm --needed base-devel
