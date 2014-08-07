# == Class: drupal::site
#
# Provides a resource to create a drupal site.
#
# === Variables
#
# [site_name]
#   The name of the site.
#
# [priority]
#   Specify a priority for this site, the default is 15.
#
# === Examples
#
#  drupal::site { 'example.com'
#    site_name => 'example.com',
#    priority => '10',
#  }
#
# === Authors
#
# Zach Seifts <zach@seifts.us
#

define drupal::site ($site_name, $priority = 15) {
    if !$site_name {
        fail ('You must set a site_name')
    }

    notify { "The site name is: ${site_name}": }

}
