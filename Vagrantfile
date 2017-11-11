Vagrant.configure("2") do |config|
	config.vm.box = "archlinux/archlinux"
	config.vm.provision "shell", inline: <<~EOS
		curl "https://www.archlinux.org/mirrorlist/?country=JP" | sed -E "s/^#S/S/g" > /etc/pacman.d/mirrorlist;
		pacman -Syu --noconfirm
	EOS
end
