# == Class: drupal::params
#
# Provides default paramters for this class
#
# === Examples
#
#  include drupal::params
#
# === Authors
#
# Zach Seifts <zach@seifts.us>
#

class drupal::params {
    $apache_user = 'www-data'
    $apache_group = 'www-data'
    $vhost_dir = '/var/www'
}
