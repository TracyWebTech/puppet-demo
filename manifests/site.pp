node default  {
  user { 'pythonbrasil':
    ensure     => present,
    managehome => true,
    shell      => '/bin/bash',
  }
}

node "agent1.tracy.com.br" inherits default { # MySQL
  include mysql
  include mysql::server

  mysql::db { 'pythonbrasil':
    user     => 'pythonbrasil',
    password => 'senhapythonbrasil',
    host     => '%',
    grant    => ['all'],
    require  => [Class['mysql'], Class['mysql::server'], Class['mysql::config']]
  }

}

