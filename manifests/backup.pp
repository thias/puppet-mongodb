# Class: mongodb::backup
#
class mongodb::backup (
  $ensure = 'present',
  $db_user = undef,
  $db_password = undef,
  $db_authdb = undef,
  $backupdir = '/var/backups/mongodb',
  $cron_hour = 3,
  $cron_minute = fqdn_rand(60),
  $cron_user = 'root',
  $oplog = undef,
  $compression_method = 'bzip2',
  $compression_args = '',
  $mail_content = 'quiet',
  $mail_maxattsize = '4000',
  $mail_addr = undef,
  $mail_pkg = 'mailx',
  $dodaily = true,
  $dailyretention = 7,
  $doweekly = true,
  $weeklyday = 6,
  $weeklyretention = 4,
  $domonthly = true,
  $monthlyretention = -1,
  $post_backup = undef,
  $divide = false,
) {

  # Ensure that the package for the mail command is installed
  if $ensure == 'present' {
    ensure_packages($mail_pkg,{ ensure => 'installed' })
  }

  file { '/usr/local/sbin/mongodb_backup':
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
    content => template("${module_name}/mongodb_backup.erb"),
  }

  cron { 'Mongo Backup':
    ensure  => $ensure,
    command => '/usr/local/sbin/mongodb_backup',
    user    => $cron_user,
    hour    => $cron_hour,
    minute  => $cron_minute,
  }

}

