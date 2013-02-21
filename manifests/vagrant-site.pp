stage { 'first': before  => Stage['main'] }
stage { 'last':  require => Stage['main'] }
class { 'profile::base':
  stage => 'first',
}

# Put your includes here

