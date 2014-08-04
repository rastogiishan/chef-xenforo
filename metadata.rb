name             'xenforo'
maintainer       'Bigpoint GmbH'
maintainer_email 't.winkler@bigpoint.net'
license          'All rights reserved'
description      'Provides a xenforo forum'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.20'
depends          'database', ">= 2.2.0"
depends          'mysql', ">= 5.0.0"
depends          "apache2", ">= 1.10.4"
depends          "apache2-wrapper"
depends          "build-essential", ">= 2.0.2"
depends          "memcached", ">= 1.7.2"
depends          "htpasswd", ">= 0.1.2"
depends          "bp-percona", ">= 0.0.8"
