# Public: installs java jre-7u21
#
# Examples
#
#    include java
class java {
  include boxen::config

  $jre_url = 'https://s3.amazonaws.com/boxen-downloads/java/jre-7u21-macosx-x64.dmg'
  $jdk_url = 'https://s3.amazonaws.com/boxen-downloads/java/jdk-7u21-macosx-x64.dmg'
  $wrapper = "${boxen::config::bindir}/java"

  package {
    'jre-7u21.dmg':
      ensure   => present,
      alias    => 'java-jre',
      provider => pkgdmg,
      source   => $jre_url ;
    'jdk-7u21.dmg':
      ensure   => present,
      alias    => 'java',
      provider => pkgdmg,
      source   => $jdk_url ;
  }

  file { $wrapper:
    source  => 'puppet:///modules/java/java.sh',
    mode    => '0755',
    require => Package['java']
  }

  file { "${boxen::config::envdir}/java_home.sh":
    source => 'puppet:///modules/java/java_home.sh' ;
  }

}
