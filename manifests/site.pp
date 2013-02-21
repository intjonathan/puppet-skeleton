node default {
  # Base runs in stage first, to ensure all the hiera, etc. prereqs are met.
  class { 'profile::base':
    stage              => 'first',
  }
}