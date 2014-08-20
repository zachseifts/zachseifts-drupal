# == Class: drupal
#
# Provides a development environment building Drupal sites.
#
# === Examples
#
#  class { drupal:
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#

class drupal {
    include drupal::webserver
    include drupal::database
}
