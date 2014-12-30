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
        mpm_module => false,
    }

    class { 'apache::mod::prefork':
        startservers    => "5",
        minspareservers => "3",
        maxspareservers => "3",
        serverlimit     => "10",
        maxclients      => "10",
    }

    class { 'apache::mod::php': }
    include apache::mod::rewrite

    class { '::php':
        composer => true,
        pear => true,
        fpm => false,
        extensions => {
            gd => {},
            mysql => {},
            xml => {},
            mbstring => {},
            'Console_Table' => {
                provider => 'pear',
                package_prefix => '',
            },
            apc => {
                package_prefix => 'php-pecl-',
            },
        },
    }

    include pear
    pear::package { 'PEAR': }
    pear::package { 'Console_Table': }
    pear::package { 'drush':
        version => '6.2.0.0',
        repository => 'drush.pear.org',
        require => Pear::Package['PEAR'],
    }
}
