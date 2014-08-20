# == Class: drupal::site
#
# Provides a resource to create a drupal site.
#
# === Variables
#
# [site_name]
#   The name of the site, it defaults to the title.
#
# [tld]
#   The domain of the site, default is .local.
#
# [priority]
#   Specify a priority for this site, the default is 15.
#
# [port]
#   Specify a port for apache to listen on, default is 80
#
# [database_name]
#   Specify a database name, default is the title.
#
# [database_user]
#   Specify a database user, default is the title.
#
# [database_password]
#   Specify a database password, default is the title.
#
# === Examples
#
#  drupal::site { 'example':
#      tld => 'com',
#      priority => '10',
#      port => '80',
#      database_name => 'database_name',
#      database_user => 'database_user',
#      database_password => 'database_password',
#  }
#
# === Authors
#
# Zach Seifts <zach@seifts.us>
#

define drupal::site ($site_name = $title,
                     $tld = 'local',
                     $priority = 15,
                     $port = 80,
                     $database_name = $title,
                     $database_user = $title,
                     $database_password = $title,
                     ) {

    include drupal::params
    $vhost_dir = $drupal::params::vhost_dir

    apache::vhost { "${site_name}.${tld}":
        priority => $priority,
        port => $port,
        docroot => "${vhost_dir}/${site_name}.${tld}",
        override => "All",
        docroot_owner => $drupal::params::apache_user,
        docroot_group => $drupal::params::apache_group,
    }

    host { "${site_name}.${tld}":
        ensure => 'present',
        ip => '127.0.0.1',
    }

    cron { "${site_name}.${tld}":
        command => "/usr/bin/drush -r ${site_name}.${tld} cron >/dev/null",
        user => $drupal::params::apache_user,
        minute => 0,
        require => Host["${site_name}.${tld}"],
    }

    mysql::db { $database_name:
        user => $database_user,
        password => $database_password,
        grant => ['all']
    }
}
