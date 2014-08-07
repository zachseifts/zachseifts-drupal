# == Class: drupal::params
#
# Provides default paramters for this class
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
