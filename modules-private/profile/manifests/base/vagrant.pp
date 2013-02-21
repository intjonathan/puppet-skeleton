# Class: profile::base::vagrant
#
#
class profile::base::vagrant(
  $create_hiera_yaml = true,
) {
  if $::virtual == 'virtualbox' {
    # Base, unchanging vagrant configuration goes here.

    # Make sure the vagrant user retains sudo access
    sudo::conf { 'vagrant':
      content => "
    # Enable full sudo access for vagrant
    Defaults:%admin !requiretty
    %admin ALL=NOPASSWD: ALL
    ",
    }

    if $create_hiera_yaml {
      # Hiera configuration for vagrant, note the datadir
      file {'/etc/puppet/hiera.yaml':
        ensure  => present,
        content => '
      :yaml:
        :datadir: /vagrant/hieradata
      :backends:
       - yaml
      :hierarchy:
       - apps/%{application}/%{environment}
       - apps/%{application}
       - hosts/%{fqdn}
       - common',
      }
    }

    # command-line hiera wants its configuration in /etc. sure, okay.
    file { '/etc/hiera.yaml':
      ensure  => link,
      target  => '/etc/puppetlabs/puppet/hiera.yaml',
    }
  }
}
