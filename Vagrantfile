# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = 'terrywang/archlinux'

  config.vm.provision 'shell', inline: 'pacman -Sy'
  config.vm.provision 'shell', inline: 'pacman -S --noconfirm pkgbuild-introspection namcap'
end
