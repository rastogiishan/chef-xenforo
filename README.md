Description
===========

Install a server with xenForo running on an apache with (optinal) ssl on it or a database instance for one or more xenForo instances.


Requirements
============

Cookbooks
---------

*  default.rb

Does absolutely nothing

* server

Installs xenForo on a machine

* _apache

Installes and configures the webserver on the xenForo node

# _firewall

Installes and configures a simple IP tables firewall

* db

Installs the database to a machine



Platform
--------

The following platforms are supported and tested under chef-spec:

* Debian (tested on wheezy64)

Newer Debian family distributions are also assumed to work.


Usage
=====

Every node needs to have xenforo or xenforodb as role. Also it needs a 'tag' with the name of the instanz. Be definition this has to be a string in the format "id-<name>[-<instance>]". F.ex. "id-biggame-02" or "id-biggame" for the db instance.


Data Bags
=========
* `passwords mysql` - The basic Percona creditentials needed by the percona cookbooks
* `xenforo db` - The db credidentials for the application
* `xenforo ssh` - The ssh credidentials needed for the git checkout
* `xenforo apache` - (optional) The certificates needed for SSL


## License & Authors
- Author:: Thorsten Winkler (<twinkler@bigpoint.net>)

```text
Copyright:: 2014 Bigpoint GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
