exec { 'apt-get update':
  command => '/usr/bin/apt-get update'
}

package { 'apache2':
  ensure => installed,
  require => Exec['apt-get update']
}

service { 'apache2':
  ensure => running,
  require => Package['apache2'],
  enable => true,     # Start on boot
}

# Remove the default apache site conf
file { '/etc/apache2/sites-enabled/000-default.conf':
  ensure => absent,
  require => Package['apache2'],
}

# Add in our example conf
file { '/etc/apache2/sites-available/example.conf':
  require => Package['apache2'],
  notify => Service['apache2'],
  source => 'puppet:///files/example.conf',
  owner => root,
  group => root,
  mode => 644,
}

# Enable our site
file { '/etc/apache2/sites-enabled/example.conf':
  ensure => 'link',
  target => '/etc/apache2/sites-available/example.conf',
  require => Package['apache2'],
  notify => Service['apache2'],
}

exec { 'fetch Example':
  creates => '/vagrant/webroot/index.html',
  command => 'mkdir -p /vagrant/webroot/ && mkdir -p /vagrant/webroot2/ && echo "<h1>Here must have been a python script but I did not manage to do it</h1><p>Hi there!</p>" > /vagrant/webroot/index.html && echo "<h1>Example2: Hello world</h1><p>Hi there!</p>" > /vagrant/webroot2/index.html',
  path => ['/bin', '/usr/bin', '/usr/local/bin'],
}