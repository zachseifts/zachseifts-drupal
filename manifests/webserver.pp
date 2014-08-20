# == Class: drupal::webserver
#
# Provides a webserver for your drupal environment.
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
