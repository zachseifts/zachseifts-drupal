# == Class: drupal::webserver
#
# Provides a webserver for your drupal environment.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  include drupal::webserver
#
# === Authors
#
# Zach Seifts <zach@seifts.us>
#

class drupal::webserver {

    class { 'apache':
        default_vhost => false,
        mpm_module => 'prefork',
    }

    apache::mod { 'rewrite': }

    class { 'apache::mod::php':
        require => Package["php5"]
    }

    package { php5:
        ensure => latest,
    }

    package { php5-gd:
        ensure => latest,
        require => Package['php5']
    }

    package { php5-mysql:
        ensure => latest,
        require => Package['php5']
    }

    package { php5-curl:
        ensure => latest,
        require => Package['php5']
    }

    package { php5-common:
        ensure => latest,
        require => Package['php5']
    }

    package { php5-cli:
        ensure => latest,
        require => Package['php5']
    }

    package { php-apc:
        ensure => latest,
        require => Package['php5']
    }

    package { php-pear:
        ensure => latest,
        require => Package['php5']
    }

    package { php-console-table:
        ensure => latest,
        require => [Package['php5'], Package['php-pear']]
    }

    package { php5-memcached:
        ensure => latest,
        require => Package['php5']
    }

    exec { 'install drush':
        command => '/usr/bin/pear channel-discover pear.drush.org && /usr/bin/pear install drush/drush',
        require => Package['php-console-table'],
        creates => '/usr/bin/drush'
    }

    package { curl:
        ensure => latest,
    }
}
