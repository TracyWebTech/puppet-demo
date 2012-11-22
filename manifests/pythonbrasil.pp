class pythonbrasil ($users) {

  $users_default = {
    ensure     => present,
    managehome => true,
    shell      => '/bin/bash'
  }
  create_resources(user, $users, $users_default)
  
}

class pythonbrasil::bd ($mysql_settings = {}) inherits pythonbrasil {
  include mysql
  include mysql::server

  mysql::server::config { 'default':
    settings => $mysql_settings
  }

  mysql::db { 'pythonbrasil':
    user     => 'pythonbrasil',
    password => 'senhapythonbrasil',
    host     => '%',
    grant    => ['all'],
    require  => [Class['mysql'], Class['mysql::server'], Class['mysql::config']]
  }
}

class pythonbrasil::site inherits pythonbrasil {
  include nginx
  include django
  include pythonbrasil_django_requirements

  nginx::site { 'pythonbrasil':
    content => template('demo/nginx/default.erb')
  }

  django::deploy { 'pythonbrasil':
    user                  => 'pythonbrasil',
    clone_path            => '/home/pythonbrasil/site',
    venv_path             => '/home/pythonbrasil/venvs/pythonbrasil',
    git_url               => 'git://github.com/pythonbrasil/pythonbrasil8.git',
    gunicorn_app_module   => 'pythonbrasil8.wsgi:application',
    settings_local        => 'pythonbrasil8/settings.py',
    settings_local_source => 'puppet:///demo/django/settings_local.py',
    migrate               => true,
    collectstatic         => true,
    fixtures              => 'sponsors',
    require               => [
                                User['pythonbrasil'], 
                                Class['pythonbrasil_django_requirements'],
                             ]
  }

}

class pythonbrasil::proxy($backends) inherits pythonbrasil {
  include nginx

  nginx::site { 'pythonbrasil-proxy':
    content => template('demo/nginx/proxy.erb')
  }

}

class pythonbrasil_django_requirements {
  package { "libmysqlclient-dev":
    ensure => installed,
  }

  package { "python-dev":
    ensure => installed,
  }

  package { "libxml2-dev":
    ensure => installed,
  }

  package { "libxslt1-dev":
    ensure => installed,
  }

  package { "build-essential":
    ensure => installed,
  }

}
