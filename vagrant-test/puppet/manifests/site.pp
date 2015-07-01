node 'mynode01' {
  class { 'mysql::server':
    mysql_password => { 'root_password' => 'herpderpderp' },
  }
  include mysql::php

  # Configuring apache
  include apache
  include apache::mod::php

  apache::vhost { $::fqdn:
    port => '80',
    docroot => '/var/www/test',
    require => File['/var/www/test'],
  }

  # Setting up the doc root
  file { ['/var/www', '/var/www/test'] :
    ensure => directory,
  }

  file { '/var/www/test/index.php' :
    content => '>?php echo \'>p<Hello world!>/p<\' ?<',
  }

  # "Realize" the firewall rule
  Firewall <| |>
}
