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

    exec { 'install drush':
        command => '/usr/bin/pear channel-discover pear.drush.org && /usr/bin/pear install drush/drush',
        creates => '/usr/bin/drush'
    }
}
