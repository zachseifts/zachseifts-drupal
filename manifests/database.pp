# == Class: drupal::database
#
# Provides database configuration
#
# === Parameters
#
# [root_password]
#   The root password for the mysql instance.
#
# === Examples
#
#  include drupal::database
#
# === Authors
#
# Zach Seifts <zach@seifts.us>
#

class drupal::database {
    $root_password = undef
} {
    if $root_password {
        $root_passwd = $root_password
    } else {
        $root_passwd = 'root'
    }

    class { '::mysql::server':
        root_password => $root_passwd,
    }
}
