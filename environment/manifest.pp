# Helpers

include apt

Exec { path => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin' }

exec { "apt-update":
  command => "apt-get update" }

exec { "install-bundler":
  command => "gem install bundler" }

exec { "run-bundle":
  command => 'su - vagrant /bin/sh -c "cd /vagrant && bundle install"',
  path => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
  timeout => 3600
}

exec { "ruby-switch":
  command => "/usr/bin/ruby-switch --set ruby2.0" }

apt::ppa { 'ppa:brightbox/ruby-ng-experimental': }



# Packages
package { 'aptitude' : }
package { 'git-core' : }
package { 'build-essential' : }
package { 'libqtwebkit-dev' : }
package { 'libpq-dev' : }
package { 'libxml2' : }
package { 'libxml2-dev' : }
package { 'libxslt-dev' : }
package { 'nodejs':}
package { 'ruby2.0' :
  require => Apt::Ppa['ppa:brightbox/ruby-ng-experimental']}
package { 'ruby2.0-dev' :
  require => Apt::Ppa['ppa:brightbox/ruby-ng-experimental']}
package { 'ruby-switch' :
  require => Apt::Ppa['ppa:brightbox/ruby-ng-experimental']}


# # Ordering
Package['ruby2.0'] ->
Exec['ruby-switch'] ->
Exec['install-bundler'] ->
Exec['run-bundle']


Exec["apt-update"] -> Package <| |>

