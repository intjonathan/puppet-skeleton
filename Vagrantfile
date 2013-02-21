# -*- mode: ruby -*-
# vi: set ft=ruby :

# So we don't track these custom changes in puppet, but the file exists so puppet doesn't implode...
if !File.exist?('manifests/vagrant-site.pp')
  File.open('manifests/vagrant-site.pp', 'w+') do |f|
    f << "stage { 'first': before  => Stage['main'] }\n"
    f << "stage { 'last':  require => Stage['main'] }\n"
    f << "class { 'profile::base':\n"
    f << "  stage => 'first',\n"
    f << "}\n\n"
    f << "# Put your includes here\n\n"
  end
end

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  # You should find a box appropriate to your infrastructure.
  config.vm.box     = "box-name-here"
  config.vm.box_url = "box-path-here#{config.vm.box}.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  config.vm.boot_mode = :gui

  #
  # Provisioning
  #

  # Ensure that Hiera is configured (otherwise things tend to explode...)
  config.vm.provision :puppet do |vagrant_config|
    # We have templates outside modules, so add those in too
    vagrant_config.module_path      = ['modules/', 'modules-private/']
    vagrant_config.manifests_path   = 'manifests'
    vagrant_config.options          = ['-e "class { profile::base: }"', '--env vagrant']
    # You must specify the manifest file, but when using the -e 
    # option as above, it is ignored
    vagrant_config.manifest_file    = 'site.pp'
  end

  # Apply our manifests
  config.vm.provision :puppet do |run_puppet|
    # We have templates outside modules, so add those in too
    run_puppet.module_path      = ['modules/', 'modules-private/']
    run_puppet.manifests_path   = "manifests"
    run_puppet.options          = ['--env vagrant']
    # separate site manifest for Vagrant
    run_puppet.manifest_file    = "vagrant-site.pp"
  end


  #
  # Targets
  #
  config.vm.define :default do |target_config|
    target_config.vm.host_name = 'default-vm'
    target_config.vm.network :hostonly, "192.168.50.24"
  end
end

