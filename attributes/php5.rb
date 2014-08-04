# Encoding: UTF-8
# PHP section
# [PHP]

###################
# About php.ini   #
###################
# PHP's initialization file, generally called php.ini, is responsible for
# configuring many of the aspects of PHP's behavior.

# PHP attempts to find and load this configuration from a number of locations.
# The following is a summary of its search order:
# 1. SAPI module specific location.
# 2. The PHPRC environment variable. (As of PHP 5.2.0)
# 3. A number of predefined registry keys on Windows (As of PHP 5.2.0)
# 4. Current working directory (except CLI)
# 5. The web server's directory (for SAPI modules), or directory of PHP
# (otherwise in Windows)
# 6. The directory from the --with-config-file-path compile time option, or the
# Windows directory (C:\windows or C:\winnt)
# See the PHP docs for more specific information.
# http://php.net/configuration.file

# The syntax of the file is extremely simple.  Whitespace and lines
# beginning with a semicolon are silently ignored (as you probably guessed).
# Section headers (e.g. [Foo]) are also silently ignored, even though
# they might mean something in the future.

# Directives following the section heading [PATH=/www/mysite] only
# apply to PHP files in the /www/mysite directory.  Directives
# following the section heading [HOST=www.example.com] only apply to
# PHP files served from www.example.com.  Directives set in these
# special sections cannot be overridden by user-defined INI files or
# at runtime. Currently, [PATH=] and [HOST=] sections only work under
# CGI/FastCGI.
# http://php.net/ini.sections

# Directives are specified using the following syntax:
# directive = value
# Directive names are *case sensitive* - foo=bar is different from FOO=bar.
# Directives are variables used to configure PHP or PHP extensions.
# There is no name validation.  If PHP can't find an expected
# directive because it is not set or is mistyped, a default value will be used.

# The value can be a string, a number, a PHP constant (e.g. E_ALL or M_PI), one
# of the INI constants (On, Off, True, False, Yes, No and None) or an expression
# (e.g. E_ALL & ~E_NOTICE), a quoted string ("bar"), or a reference to a
# previously set variable or directive (e.g. ${foo})

# Expressions in the INI file are limited to bitwise operators and parentheses:
# |  bitwise OR
# ^  bitwise XOR
# &  bitwise AND
# ~  bitwise NOT
# !  boolean NOT

# Boolean flags can be turned on using the values 1, On, True or Yes.
# They can be turned off using the values 0, Off, False or No.

# An empty string can be denoted by simply not writing anything after the equal
# sign, or by using the None keyword:

#  foo =         # sets foo to an empty string
#  foo = None    # sets foo to an empty string
#  foo = "None"  # sets foo to the string 'None'

# If you use constants in your value, and these constants belong to a
# dynamically loaded extension (either a PHP extension or a Zend extension),
# you may only use these constants *after* the line that loads the extension.

###################
# About this file #
###################
# PHP comes packaged with two INI files. One that is recommended to be used
# in production environments and one that is recommended to be used in
# development environments.

# php.ini-production contains settings which hold security, performance and
# best practices at its core. But please be aware, these settings may break
# compatibility with older or less security conscience applications. We
# recommending using the production ini in production and testing environments.

# php.ini-development is very similar to its production variant, except it's
# much more verbose when it comes to errors. We recommending using the
# development version only in development environments as errors shown to
# application users can inadvertently leak otherwise secure information.

# This is php.ini-production INI file.

###################
# Quick Reference #
###################
# The following are all the settings which are different in either the production
# or development versions of the INIs with respect to PHP's default behavior.
# Please see the actual settings later in the document for more details as to why
# we recommend these changes in PHP's behavior.

# display_errors
#   Default Value: On
#   Development Value: On
#   Production Value: Off

# display_startup_errors
#   Default Value: Off
#   Development Value: On
#   Production Value: Off

# error_reporting
#   Default Value: E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED
#   Development Value: E_ALL
#   Production Value: E_ALL & ~E_DEPRECATED & ~E_STRICT

# html_errors
#   Default Value: On
#   Development Value: On
#   Production value: On

# log_errors
#   Default Value: Off
#   Development Value: On
#   Production Value: On

# max_input_time
#   Default Value: -1 (Unlimited)
#   Development Value: 60 (60 seconds)
#   Production Value: 60 (60 seconds)

# output_buffering
#   Default Value: Off
#   Development Value: 4096
#   Production Value: 4096

# register_argc_argv
#   Default Value: On
#   Development Value: Off
#   Production Value: Off

# request_order
#   Default Value: None
#   Development Value: "GP"
#   Production Value: "GP"

# session.bug_compat_42
#   Default Value: On
#   Development Value: On
#   Production Value: Off

# session.bug_compat_warn
#   Default Value: On
#   Development Value: On
#   Production Value: Off

# session.gc_divisor
#   Default Value: 100
#   Development Value: 1000
#   Production Value: 1000

# session.hash_bits_per_character
#   Default Value: 4
#   Development Value: 5
#   Production Value: 5

# short_open_tag
#   Default Value: On
#   Development Value: Off
#   Production Value: Off

# track_errors
#   Default Value: Off
#   Development Value: On
#   Production Value: Off

# url_rewriter.tags
#   Default Value: "a=href,area=href,frame=src,form=,fieldset="
#   Development Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
#   Production Value: "a=href,area=href,frame=src,input=src,form=fakeentry"

# variables_order
#   Default Value: "EGPCS"
#   Development Value: "GPCS"
#   Production Value: "GPCS"

####################
# php.ini Options  #
####################
# Name for user-defined php.ini (.htaccess) files. Default is ".user.ini"
default['xenforo']['php']['user_ini']['filename'] = nil

# To disable this feature set this option to empty value
default['xenforo']['php']['user_ini']['filename'] = nil

# TTL for user-defined php.ini files (time-to-live) in seconds. Default is 300 seconds (5 minutes)
default['xenforo']['php']['user_ini']['cache_ttl'] = nil

####################
# Language Options #
####################

# Enable the PHP scripting language engine under Apache.
# http://php.net/engine
default['xenforo']['php']['engine'] = 'On'

# This directive determines whether or not PHP will recognize code between
# <? and ?> tags as PHP source which should be processed as such. It's been
# recommended for several years that you not use the short tag "short cut" and
# instead to use the full <?php and ?> tag combination. With the wide spread use
# of XML and use of these tags by other languages, the server can become easily
# confused and end up parsing the wrong code in the wrong context. But because
# this short cut has been a feature for such a long time, it's currently still
# supported for backwards compatibility, but we recommend you don't use them.
# Default Value: On
# Development Value: Off
# Production Value: Off
# http://php.net/short-open-tag
default['xenforo']['php']['short_open_tag'] = 'On'

# Allow ASP-style <% %> tags.
# http://php.net/asp-tags
default['xenforo']['php']['asp_tags'] = 'Off'

# The number of significant digits displayed in floating point numbers.
# http://php.net/precision
default['xenforo']['php']['precision'] = 14

# Output buffering is a mechanism for controlling how much output data
# (excluding headers and cookies) PHP should keep internally before pushing that
# data to the client. If your application's output exceeds this setting, PHP
# will send that data in chunks of roughly the size you specify.
# Turning on this setting and managing its maximum buffer size can yield some
# interesting side-effects depending on your application and web server.
# You may be able to send headers and cookies after you've already sent output
# through print or echo. You also may see performance benefits if your server is
# emitting less packets due to buffered output versus PHP streaming the output
# as it gets it. On production servers, 4096 bytes is a good setting for performance
# reasons.
# Note: Output buffering can also be controlled via Output Buffering Control
#   functions.
# Possible Values:
#   On = Enabled and buffer is unlimited. (Use with caution)
#   Off = Disabled
#   Integer = Enables the buffer and sets its maximum size in bytes.
# Note: This directive is hardcoded to Off for the CLI SAPI
# Default Value: Off
# Development Value: 4096
# Production Value: 4096
# http://php.net/output-buffering
default['xenforo']['php']['output_buffering'] = 4096

# You can redirect all of the output of your scripts to a function.  For
# example, if you set output_handler to "mb_output_handler", character
# encoding will be transparently converted to the specified encoding.
# Setting any output handler automatically turns on output buffering.
# Note: People who wrote portable scripts should not depend on this ini
#   directive. Instead, explicitly set the output handler using ob_start().
#   Using this ini directive may cause problems unless you know what script
#   is doing.
# Note: You cannot use both "mb_output_handler" with "ob_iconv_handler"
#   and you cannot use both "ob_gzhandler" and "zlib.output_compression".
# Note: output_handler must be empty if this is set 'On' !!!!
#   Instead you must use zlib.output_handler.
# http://php.net/output-handler
default['xenforo']['php']['output_handler'] = nil

# Transparent output compression using the zlib library
# Valid values for this option are 'off', 'on', or a specific buffer size
# to be used for compression (default is 4KB)
# Note: Resulting chunk size may vary due to nature of compression. PHP
#   outputs chunks that are few hundreds bytes each as a result of
#   compression. If you prefer a larger chunk size for better
#   performance, enable output_buffering in addition.
# Note: You need to use zlib.output_handler instead of the standard
#   output_handler, or otherwise the output will be corrupted.
# http://php.net/zlib.output-compression
default['xenforo']['php']['zlib']['output_compression'] = 'Off'

# http://php.net/zlib.output-compression-level
default['xenforo']['php']['zlib']['output_compression_level'] = nil

# You cannot specify additional output handlers if zlib.output_compression
# is activated here. This setting does the same as output_handler but in
# a different order.
# http://php.net/zlib.output-handler
default['xenforo']['php']['zlib']['output_handler'] = nil

# Implicit flush tells PHP to tell the output layer to flush itself
# automatically after every output block.  This is equivalent to calling the
# PHP function flush() after each and every call to print() or echo() and each
# and every HTML block.  Turning this option on has serious performance
# implications and is generally recommended for debugging purposes only.
# http://php.net/implicit-flush
# Note: This directive is hardcoded to On for the CLI SAPI
default['xenforo']['php']['implicit_flush'] = 'Off'

# The unserialize callback function will be called (with the undefined class'
# name as parameter), if the unserializer finds an undefined class
# which should be instantiated. A warning appears if the specified function is
# not defined, or if the function doesn't include/implement the missing class.
# So only set this entry, if you really want to implement such a
# callback-function.
default['xenforo']['php']['unserialize_callback_func'] = ''

# When floats & doubles are serialized store serialize_precision significant
# digits after the floating point. The default value ensures that when floats
# are decoded with unserialize, the data will remain the same.
default['xenforo']['php']['serialize_precision'] = 17

# open_basedir, if set, limits all file operations to the defined directory
# and below.  This directive makes most sense if used in a per-directory
# or per-virtualhost web server configuration file. This directive is
# *NOT* affected by whether Safe Mode is turned On or Off.
# http://php.net/open-basedir
default['xenforo']['php']['open_basedir'] = node['apache']['docroot_dir']

# This directive allows you to disable certain functions for security reasons.
# It receives a comma-delimited list of function names. This directive is
# *NOT* affected by whether Safe Mode is turned On or Off.
# http://php.net/disable-functions
#default['xenforo']['php']['disable_functions'] = 'pcntl_alarm,pcntl_fork,' + \
#'pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,' + \
#'pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,' + \
#'pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,' + \
#'pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,'

default['xenforo']['php']['disable_functions'] = 'pcntl_alarm,pcntl_fork,'+ \
'pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,' + \
'pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,' + \
'pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,' + \
'pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,exec,' + \
'passthru,shell_exec,system,proc_open,popen,curl_exec,curl_multi_exec,' + \
'parse_ini_file,show_source'

# This directive allows you to disable certain classes for security reasons.
# It receives a comma-delimited list of class names. This directive is
# *NOT* affected by whether Safe Mode is turned On or Off.
# http://php.net/disable-classes
default['xenforo']['php']['disable_classes'] = ''

# Colors for Syntax Highlighting mode.  Anything that's acceptable in
# <span style="color: ???????"> would work.
# http://php.net/syntax-highlighting
default['xenforo']['php']['highlight']['string'] = nil
default['xenforo']['php']['highlight']['comment'] = nil
default['xenforo']['php']['highlight']['keyword'] = nil
default['xenforo']['php']['highlight']['default'] = nil
default['xenforo']['php']['highlight']['html'] = nil

# If enabled, the request will be allowed to complete even if the user aborts
# the request. Consider enabling it if executing long requests, which may end up
# being interrupted by the user or a browser timing out. PHP's default behavior
# is to disable this feature.
# http://php.net/ignore-user-abort
default['xenforo']['php']['ignore_user_abort'] = nil

# Determines the size of the realpath cache to be used by PHP. This value should
# be increased on systems where PHP opens many files to reflect the quantity of
# the file operations performed.
# http://php.net/realpath-cache-size
default['xenforo']['php']['realpath_cache_size'] = nil

# Duration of time, in seconds for which to cache realpath information for a given
# file or directory. For systems with rarely changing files, consider increasing this
# value.
# http://php.net/realpath-cache-ttl
default['xenforo']['php']['realpath_cache_ttl'] = nil

# Enables or disables the circular reference collector.
# http://php.net/zend.enable-gc
default['xenforo']['php']['zend']['enable_gc'] = 'On'

# If enabled, scripts may be written in encodings that are incompatible with
# the scanner.  CP936, Big5, CP949 and Shift_JIS are the examples of such
# encodings.  To use this feature, mbstring extension must be enabled.
# Default: Off
default['xenforo']['php']['zend']['multibyte'] = nil

# Allows to set the default encoding for the scripts.  This value will be used
# unless "declare(encoding=...)" directive appears at the top of the script.
# Only affects if zend.multibyte is set.
# Default: ""
default['xenforo']['php']['zend']['script_encoding'] = nil

#################
# Miscellaneous #
#################

# Decides whether PHP may expose the fact that it is installed on the server
# (e.g. by adding its signature to the Web server header).  It is no security
# threat in any way, but it makes it possible to determine whether you use PHP
# on your server or not.
# http://php.net/expose-php
default['xenforo']['php']['expose_php'] = 'Off'

###################
# Resource Limits #
###################

# Maximum execution time of each script, in seconds
# http://php.net/max-execution-time
# Note: This directive is hardcoded to 0 for the CLI SAPI
default['xenforo']['php']['max_execution_time'] = 30

# Maximum amount of time each script may spend parsing request data. It's a good
# idea to limit this time on productions servers in order to eliminate unexpectedly
# long running scripts.
# Note: This directive is hardcoded to -1 for the CLI SAPI
# Default Value: -1 (Unlimited)
# Development Value: 60 (60 seconds)
# Production Value: 60 (60 seconds)
# http://php.net/max-input-time
default['xenforo']['php']['max_input_time'] = 30

# Maximum input variable nesting level
# http://php.net/max-input-nesting-level
default['xenforo']['php']['max_input_nesting_level'] = nil

# How many GET/POST/COOKIE input variables may be accepted
# max_input_vars = 1000

# Maximum amount of memory a script may consume (128MB)
# http://php.net/memory-limit
default['xenforo']['php']['memory_limit'] = '8M'

##############################
# Error handling and logging #
##############################

# This directive informs PHP of which errors, warnings and notices you would like
# it to take action for. The recommended way of setting values for this
# directive is through the use of the error level constants and bitwise
# operators. The error level constants are below here for convenience as well as
# some common settings and their meanings.
# By default, PHP is set to take action on all errors, notices and warnings EXCEPT
# those related to E_NOTICE and E_STRICT, which together cover best practices and
# recommended coding standards in PHP. For performance reasons, this is the
# recommend error reporting setting. Your production server shouldn't be wasting
# resources complaining about best practices and coding standards. That's what
# development servers and development settings are for.
# Note: The php.ini-development file has this setting as E_ALL. This
# means it pretty much reports everything which is exactly what you want during
# development and early testing.
#
# Error Level Constants:
# E_ALL             - All errors and warnings (includes E_STRICT as of PHP 5.4.0)
# E_ERROR           - fatal run-time errors
# E_RECOVERABLE_ERROR  - almost fatal run-time errors
# E_WARNING         - run-time warnings (non-fatal errors)
# E_PARSE           - compile-time parse errors
# E_NOTICE          - run-time notices (these are warnings which often result
#                     from a bug in your code, but it's possible that it was
#                     intentional (e.g., using an uninitialized variable and
#                     relying on the fact it's automatically initialized to an
#                     empty string)
# E_STRICT          - run-time notices, enable to have PHP suggest changes
#                     to your code which will ensure the best interoperability
#                     and forward compatibility of your code
# E_CORE_ERROR      - fatal errors that occur during PHP's initial startup
# E_CORE_WARNING    - warnings (non-fatal errors) that occur during PHP's
#                     initial startup
# E_COMPILE_ERROR   - fatal compile-time errors
# E_COMPILE_WARNING - compile-time warnings (non-fatal errors)
# E_USER_ERROR      - user-generated error message
# E_USER_WARNING    - user-generated warning message
# E_USER_NOTICE     - user-generated notice message
# E_DEPRECATED      - warn about code that will not work in future versions
#                     of PHP
# E_USER_DEPRECATED - user-generated deprecation warnings
#
# Common Values:
#   E_ALL (Show all errors, warnings and notices including coding standards.)
#   E_ALL & ~E_NOTICE  (Show all errors, except for notices)
#   E_ALL & ~E_NOTICE & ~E_STRICT  (Show all errors, except for notices and
#                                   coding standards warnings.)
#   E_COMPILE_ERROR|E_RECOVERABLE_ERROR|E_ERROR|E_CORE_ERROR  (Show only errors)
# Default Value: E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED
# Development Value: E_ALL
# Production Value: E_ALL & ~E_DEPRECATED & ~E_STRICT
# http://php.net/error-reporting
default['xenforo']['php']['error_reporting'] = 'E_ALL & ~E_DEPRECATED & ~E_STRICT'

# This directive controls whether or not and where PHP will output errors,
# notices and warnings too. Error output is very useful during development, but
# it could be very dangerous in production environments. Depending on the code
# which is triggering the error, sensitive information could potentially leak
# out of your application such as database usernames and passwords or worse.
# It's recommended that errors be logged on production servers rather than
# having the errors sent to STDOUT.
# Possible Values:
#   Off = Do not display any errors
#   stderr = Display errors to STDERR (affects only CGI/CLI binaries!)
#   On or stdout = Display errors to STDOUT
# Default Value: On
# Development Value: On
# Production Value: Off
# http://php.net/display-errors
default['xenforo']['php']['display_errors'] = 'Off'

# The display of errors which occur during PHP's startup sequence are handled
# separately from display_errors. PHP's default behavior is to suppress those
# errors from clients. Turning the display of startup errors on can be useful in
# debugging configuration problems. But, it's strongly recommended that you
# leave this setting off on production servers.
# Default Value: Off
# Development Value: On
# Production Value: Off
# http://php.net/display-startup-errors
default['xenforo']['php']['display_startup_errors'] = 'Off'

# Besides displaying errors, PHP can also log errors to locations such as a
# server-specific log, STDERR, or a location specified by the error_log
# directive found below. While errors should not be displayed on productions
# servers they should still be monitored and logging is a great way to do that.
# Default Value: Off
# Development Value: On
# Production Value: On
# http://php.net/log-errors
default['xenforo']['php']['log_errors'] = 'On'

# Set maximum length of log_errors. In error_log information about the source is
# added. The default is 1024 and 0 allows to not apply any maximum length at all.
# http://php.net/log-errors-max-len
default['xenforo']['php']['log_errors_max_len'] = 1024

# Do not log repeated messages. Repeated errors must occur in same file on same
# line unless ignore_repeated_source is set true.
# http://php.net/ignore-repeated-errors
default['xenforo']['php']['ignore_repeated_errors'] = 'Off'

# Ignore source of message when ignoring repeated messages. When this setting
# is On you will not log errors with repeated messages from different files or
# source lines.
# http://php.net/ignore-repeated-source
default['xenforo']['php']['ignore_repeated_source'] = 'Off'

# If this parameter is set to Off, then memory leaks will not be shown (on
# stdout or in the log). This has only effect in a debug compile, and if
# error reporting includes E_WARNING in the allowed list
# http://php.net/report-memleaks
default['xenforo']['php']['report_memleaks'] = 'On'

# This setting is on by default.
default['xenforo']['php']['report_zend_debug'] = nil

# Store the last error/warning message in $php_errormsg (boolean). Setting this value
# to On can assist in debugging and is appropriate for development servers. It should
# however be disabled on production servers.
# Default Value: Off
# Development Value: On
# Production Value: Off
# http://php.net/track-errors
default['xenforo']['php']['track_errors'] = 'Off'

# Turn off normal error reporting and emit XML-RPC error XML
# http://php.net/xmlrpc-errors
default['xenforo']['php']['xmlrpc_errors'] = nil

# An XML-RPC faultCode
default['xenforo']['php']['xmlrpc_error_number'] = nil

# When PHP displays or logs an error, it has the capability of formatting the
# error message as HTML for easier reading. This directive controls whether
# the error message is formatted as HTML or not.
# Note: This directive is hardcoded to Off for the CLI SAPI
# Default Value: On
# Development Value: On
# Production value: On
# http://php.net/html-errors
default['xenforo']['php']['html_errors'] = 'On'

# If html_errors is set to On *and* docref_root is not empty, then PHP
# produces clickable error messages that direct to a page describing the error
# or function causing the error in detail.
# You can download a copy of the PHP manual from http://php.net/docs
# and change docref_root to the base URL of your local copy including the
# leading '/'. You must also specify the file extension being used including
# the dot. PHP's default behavior is to leave these settings empty, in which
# case no links to documentation are generated.
# Note: Never use this feature for production boxes.
# http://php.net/docref-root
# Examples
default['xenforo']['php']['docref_root'] = nil

# http://php.net/docref-ext
default['xenforo']['php']['docref_ext'] = nil

# String to output before an error message. PHP's default behavior is to leave
# this setting blank.
# http://php.net/error-prepend-string
# Example:
default['xenforo']['php']['error_prepend_string'] = nil

# String to output after an error message. PHP's default behavior is to leave
# this setting blank.
# http://php.net/error-append-string
# Example:
default['xenforo']['php']['error_append_string'] = nil

# Log errors to specified file. PHP's default behavior is to leave this value
# empty.
# http://php.net/error-log
# Example:
default['xenforo']['php']['error_log'] = nil
# Log errors to syslog (Event Log on NT, not valid in Windows 95).
default['xenforo']['php']['error_log'] = nil

# windows.show_crt_warning
# Default value: 0
# Development value: 0
# Production value: 0

#################
# Data Handling #
#################

# The separator used in PHP generated URLs to separate arguments.
# PHP's default setting is "&".
# http://php.net/arg-separator.output
# Example:
default['xenforo']['php']['arg_separator']['output'] = nil

# List of separator(s) used by PHP to parse input URLs into variables.
# PHP's default setting is "&".
# NOTE: Every character in this directive is considered as separator!
# http://php.net/arg-separator.input
# Example:
default['xenforo']['php']['arg_separator']['input'] = nil

# This directive determines which super global arrays are registered when PHP
# starts up. G,P,C,E & S are abbreviations for the following respective super
# globals: GET, POST, COOKIE, ENV and SERVER. There is a performance penalty
# paid for the registration of these arrays and because ENV is not as commonly
# used as the others, ENV is not recommended on productions servers. You
# can still get access to the environment variables through getenv() should you
# need to.
# Default Value: "EGPCS"
# Development Value: "GPCS"
# Production Value: "GPCS"#
# http://php.net/variables-order
default['xenforo']['php']['variables_order'] = 'GPCS'

# This directive determines which super global data (G,P,C,E & S) should
# be registered into the super global array REQUEST. If so, it also determines
# the order in which that data is registered. The values for this directive are
# specified in the same manner as the variables_order directive, EXCEPT one.
# Leaving this value empty will cause PHP to use the value set in the
# variables_order directive. It does not mean it will leave the super globals
# array REQUEST empty.
# Default Value: None
# Development Value: "GP"
# Production Value: "GP"
# http://php.net/request-order
default['xenforo']['php']['request_order'] = 'GP'

# This directive determines whether PHP registers $argv & $argc each time it
# runs. $argv contains an array of all the arguments passed to PHP when a script
# is invoked. $argc contains an integer representing the number of arguments
# that were passed when the script was invoked. These arrays are extremely
# useful when running scripts from the command line. When this directive is
# enabled, registering these variables consumes CPU cycles and memory each time
# a script is executed. For performance reasons, this feature should be disabled
# on production servers.
# Note: This directive is hardcoded to On for the CLI SAPI
# Default Value: On
# Development Value: Off
# Production Value: Off
# http://php.net/register-argc-argv
default['xenforo']['php']['register_argc_argv'] = 'Off'

# When enabled, the ENV, REQUEST and SERVER variables are created when they're
# first used (Just In Time) instead of when the script starts. If these
# variables are not used within a script, having this directive on will result
# in a performance gain. The PHP directive register_argc_argv must be disabled
# for this directive to have any affect.
# http://php.net/auto-globals-jit
default['xenforo']['php']['auto_globals_jit'] = 'On'

# Whether PHP will read the POST data.
# This option is enabled by default.
# Most likely, you won't want to disable this option globally. It causes $_POST
# and $_FILES to always be empty# the only way you will be able to read the
# POST data will be through the php://input stream wrapper. This can be useful
# to proxy requests or to process the POST data in a memory efficient fashion.
# http://php.net/enable-post-data-reading
default['xenforo']['php']['enable_post_data_reading'] = nil

# Maximum size of POST data that PHP will accept.
# Its value may be 0 to disable the limit. It is ignored if POST data reading
# is disabled through enable_post_data_reading.
# http://php.net/post-max-size
default['xenforo']['php']['post_max_size'] = '8M'

# Automatically add files before PHP document.
# http://php.net/auto-prepend-file
default['xenforo']['php']['auto_prepend_file'] = ''

# Automatically add files after PHP document.
# http://php.net/auto-append-file
default['xenforo']['php']['auto_append_file'] = ''

# By default, PHP will output a character encoding using
# the Content-type: header.  To disable sending of the charset, simply
# set it to be empty.
#
# PHP's built-in default is text/html
# http://php.net/default-mimetype
default['xenforo']['php']['default_mimetype'] = 'text/html'

# PHP's default character set is set to empty.
# http://php.net/default-charset
default['xenforo']['php']['default_charset'] = nil

# Always populate the $HTTP_RAW_POST_DATA variable. PHP's default behavior is
# to disable this feature. If post reading is disabled through
# enable_post_data_reading, $HTTP_RAW_POST_DATA is *NOT* populated.
# http://php.net/always-populate-raw-post-data
default['xenforo']['php']['always_populate_raw_post_data'] = nil

#########################
# Paths and Directories #
#########################

# UNIX: "/path1:/path2"
default['xenforo']['php']['include_path'] = nil
#
# Windows: "\path1#\path2"
default['xenforo']['php']['include_path'] = nil
#
# PHP's default setting for include_path is ".#/path/to/php/pear"
# http://php.net/include-path

# The root of the PHP pages, used only if nonempty.
# if PHP was not compiled with FORCE_REDIRECT, you SHOULD set doc_root
# if you are running php as a CGI under any web server (other than IIS)
# see documentation for security issues.  The alternate is to use the
# cgi.force_redirect configuration below
# http://php.net/doc-root
default['xenforo']['php']['doc_root'] = ''

# The directory under which PHP opens the script using /~username used only
# if nonempty.
# http://php.net/user-dir
default['xenforo']['php']['user_dir'] = ''

# Directory in which the loadable extensions (modules) reside.
# http://php.net/extension-dir
# extension_dir = "./"
# On windows:
# extension_dir = "ext"

# Whether or not to enable the dl() function.  The dl() function does NOT work
# properly in multithreaded servers, such as IIS or Zeus, and is automatically
# disabled on them.
# http://php.net/enable-dl
default['xenforo']['php']['enable_dl'] = 'Off'

# cgi.force_redirect is necessary to provide security running PHP as a CGI under
# most web servers.  Left undefined, PHP turns this on by default.  You can
# turn it off here AT YOUR OWN RISK
# **You CAN safely turn this off for IIS, in fact, you MUST.**
# http://php.net/cgi.force-redirect
default['xenforo']['php']['cgi']['force_redirect'] = nil

# if cgi.nph is enabled it will force cgi to always sent Status: 200 with
# every request. PHP's default behavior is to disable this feature.
default['xenforo']['php']['cgi']['nph'] = nil

# if cgi.force_redirect is turned on, and you are not running under Apache or Netscape
# (iPlanet) web servers, you MAY need to set an environment variable name that PHP
# will look for to know it is OK to continue execution.  Setting this variable MAY
# cause security issues, KNOW WHAT YOU ARE DOING FIRST.
# http://php.net/cgi.redirect-status-env
default['xenforo']['php']['cgi']['redirect_status_env'] = nil

# cgi.fix_pathinfo provides *real* PATH_INFO/PATH_TRANSLATED support for CGI.  PHP's
# previous behaviour was to set PATH_TRANSLATED to SCRIPT_FILENAME, and to not grok
# what PATH_INFO is.  For more information on PATH_INFO, see the cgi specs.  Setting
# this to 1 will cause PHP CGI to fix its paths to conform to the spec.  A setting
# of zero causes PHP to behave as before.  Default is 1.  You should fix your scripts
# to use SCRIPT_FILENAME rather than PATH_TRANSLATED.
# http://php.net/cgi.fix-pathinfo
default['xenforo']['php']['cgi']['fix_pathinfo'] = nil

# FastCGI under IIS (on WINNT based OS) supports the ability to impersonate
# security tokens of the calling client.  This allows IIS to define the
# security context that the request runs under.  mod_fastcgi under Apache
# does not currently support this feature (03/17/2002)
# Set to 1 if running under IIS.  Default is zero.
# http://php.net/fastcgi.impersonate
default['xenforo']['php']['fastcgi']['impersonate'] = nil

# Disable logging through FastCGI connection. PHP's default behavior is to enable
# this feature.
default['xenforo']['php']['fastcgi']['logging'] = nil

# cgi.rfc2616_headers configuration option tells PHP what type of headers to
# use when sending HTTP response code. If it's set 0 PHP sends Status: header that
# is supported by Apache. When this option is set to 1 PHP will send
# RFC2616 compliant header.
# Default is zero.
# http://php.net/cgi.rfc2616-headers
default['xenforo']['php']['cgi']['rfc2616_headers'] = nil

################
# File Uploads #
################

# Whether to allow HTTP file uploads.
# http://php.net/file-uploads
default['xenforo']['php']['file_uploads'] = 'On'

# Temporary directory for HTTP uploaded files (will use system default if not
# specified).
# http://php.net/upload-tmp-dir
default['xenforo']['php']['upload_tmp_dir'] = "#{node['apache']['docroot_dir']}/#{node['xenforo']['name']}-uploads"

# Maximum allowed size for uploaded files.
# http://php.net/upload-max-filesize
default['xenforo']['php']['upload_max_filesize'] = '2M'

# Maximum number of files that can be uploaded via a single request
default['xenforo']['php']['max_file_uploads'] = 20

##################
# Fopen wrappers #
##################

# Whether to allow the treatment of URLs (like http:// or ftp://) as files.
# http://php.net/allow-url-fopen
default['xenforo']['php']['allow_url_fopen'] = 'Off'

# Whether to allow include/require to open URLs (like http:// or ftp://) as files.
# http://php.net/allow-url-include
default['xenforo']['php']['allow_url_include'] = 'Off'

# Define the anonymous ftp password (your email address). PHP's default setting
# for this is empty.
# http://php.net/from
default['xenforo']['php']['from'] = nil

# Define the User-Agent string. PHP's default setting for this is empty.
# http://php.net/user-agent
default['xenforo']['php']['user_agent'] = nil

# Default timeout for socket based streams (seconds)
# http://php.net/default-socket-timeout
default['xenforo']['php']['default_socket_timeout'] = 60

# If your scripts have to deal with files from Macintosh systems,
# or you are running on a Mac and need to deal with files from
# unix or win32 systems, setting this flag will cause PHP to
# automatically detect the EOL character in those files so that
# fgets() and file() will work regardless of the source of the file.
# http://php.net/auto-detect-line-endings
default['xenforo']['php']['auto_detect_line_endings'] = nil

######################
# Dynamic Extensions #
######################

# If you wish to have an extension loaded automatically, use the following
# syntax:
#
#   extension=modulename.extension
#
# For example, on Windows:
#
#   extension=msql.dll
#
# ... or under UNIX:
#
#   extension=msql.so
#
# ... or with a path:
#
#   extension=/path/to/extension/msql.so
#
# If you only provide the name of the extension, PHP will look for it in its
# default extension directory.
#

###################
# Module Settings #
###################

# [CLI Server]
# Whether the CLI web server uses ANSI color coding in its terminal output.
default['xenforo']['php']['cli_server']['color'] = 'On'

# [Date]
# Defines the default timezone used by the date functions
# http://php.net/date.timezone
default['xenforo']['php']['date']['timezone'] = nil

# http://php.net/date.default-latitude
default['xenforo']['php']['date']['default_latitude'] = nil

# http://php.net/date.default-longitude
default['xenforo']['php']['date']['default_longitude'] = nil

# http://php.net/date.sunrise-zenith
default['xenforo']['php']['date']['sunrise_zenith'] = nil

# http://php.net/date.sunset-zenith
default['xenforo']['php']['date']['sunset_zenith'] = nil

# [filter]
# http://php.net/filter.default
default['xenforo']['php']['filter']['default'] = nil

# http://php.net/filter.default-flags
default['xenforo']['php']['filter']['default_flags'] = nil

# [iconv]
default['xenforo']['php']['iconv']['input_encoding'] = nil
default['xenforo']['php']['iconv']['internal_encoding'] = nil
default['xenforo']['php']['iconv']['output_encoding'] = nil

# [intl]
default['xenforo']['php']['intl']['default_locale'] = nil
# This directive allows you to produce PHP errors when some error
# happens within intl functions. The value is the level of the error produced.
# Default is 0, which does not produce any errors.
default['xenforo']['php']['intl']['error_level'] = nil

# [sqlite]
# http://php.net/sqlite.assoc-case
default['xenforo']['php']['sqlite']['assoc_case'] = nil

# [sqlite3]
default['xenforo']['php']['sqlite3']['extension_dir'] = nil

# [Pcre]
# PCRE library backtracking limit.
# http://php.net/pcre.backtrack-limit
default['xenforo']['php']['pcre']['backtrack_limit'] = nil

# PCRE library recursion limit.
# Please note that if you set this value to a high number you may consume all
# the available process stack and eventually crash PHP (due to reaching the
# stack size limit imposed by the Operating System).
# http://php.net/pcre.recursion-limit
default['xenforo']['php']['pcre']['recursion_limit'] = nil

# [Pdo]
# Whether to pool ODBC connections. Can be one of "strict", "relaxed" or "off"
# http://php.net/pdo-odbc.connection-pooling
default['xenforo']['php']['pdo_odbc']['connection_pooling'] = nil

# pdo_odbc.db2_instance_name

# [Pdo_mysql]
# If mysqlnd is used: Number of cache slots for the internal result set cache
# http://php.net/pdo_mysql.cache_size
default['xenforo']['php']['pdo_mysql']['cache_size'] = 2000

# Default socket name for local MySQL connects.  If empty, uses the built-in
# MySQL defaults.
# http://php.net/pdo_mysql.default-socket
default['xenforo']['php']['pdo_mysql']['default_socket'] = ''

# [Phar]
# http://php.net/phar.readonly
default['xenforo']['php']['phar']['readonly'] = nil

# http://php.net/phar.require-hash
default['xenforo']['php']['phar']['require_hash'] = nil

default['xenforo']['php']['phar']['cache_list'] = nil

# [mail function]
# For Win32 only.
# http://php.net/smtp
default['xenforo']['php']['SMTP'] = 'localhost'
# http://php.net/smtp-port
default['xenforo']['php']['smtp_port'] = 25

# For Win32 only.
# http://php.net/sendmail-from
default['xenforo']['php']['sendmail_from'] = nil

# For Unix only.  You may supply arguments as well (default: "sendmail -t -i").
# http://php.net/sendmail-path
default['xenforo']['php']['sendmail_path'] = nil

# Force the addition of the specified parameters to be passed as extra parameters
# to the sendmail binary. These parameters will always replace the value of
# the 5th parameter to mail(), even in safe mode.
default['xenforo']['php']['mail']['force_extra_parameters'] = nil

# Add X-PHP-Originating-Script: that will include uid of the script followed by the filename
default['xenforo']['php']['mail']['add_x_header'] = 'On'

# The path to a log file that will log all mail() calls. Log entries include
# the full path of the script, line number, To address and headers.
default['xenforo']['php']['mail']['log'] = nil

# [SQL]
# http://php.net/sql.safe-mode
default['xenforo']['php']['sql']['safe_mode'] = 'On'

# [ODBC]
# http://php.net/odbc.default-db
default['xenforo']['php']['odbc']['default_db'] = nil

# http://php.net/odbc.default-user
default['xenforo']['php']['odbc']['default_user'] = nil

# http://php.net/odbc.default-pw
default['xenforo']['php']['odbc']['default_pw'] = nil

# Controls the ODBC cursor model.
# Default: SQL_CURSOR_STATIC (default).
# odbc.default_cursortype

# Allow or prevent persistent links.
# http://php.net/odbc.allow-persistent
default['xenforo']['php']['odbc']['allow_persistent'] = 'On'

# Check that a connection is still valid before reuse.
# http://php.net/odbc.check-persistent
default['xenforo']['php']['odbc']['check_persistent'] = 'On'

# Maximum number of persistent links.  -1 means no limit.
# http://php.net/odbc.max-persistent
default['xenforo']['php']['odbc']['max_persistent'] = -1

# Maximum number of links (persistent + non-persistent).  -1 means no limit.
# http://php.net/odbc.max-links
default['xenforo']['php']['odbc']['max_links'] = -1

# Handling of LONG fields.  Returns number of bytes to variables.  0 means
# passthru.
# http://php.net/odbc.defaultlrl
default['xenforo']['php']['odbc']['defaultlrl'] = 4096

# Handling of binary data.  0 means passthru, 1 return as is, 2 convert to char.
# See the documentation on odbc_binmode and odbc_longreadlen for an explanation
# of odbc.defaultlrl and odbc.defaultbinmode
# http://php.net/odbc.defaultbinmode
default['xenforo']['php']['odbc']['defaultbinmode'] = 1

default['xenforo']['php']['birdstep']['max_links'] = nil

# [Interbase]
# Allow or prevent persistent links.
default['xenforo']['php']['ibase']['allow_persistent'] = 1

# Maximum number of persistent links.  -1 means no limit.
default['xenforo']['php']['ibase']['max_persistent'] = -1

# Maximum number of links (persistent + non-persistent).  -1 means no limit.
default['xenforo']['php']['ibase']['max_links'] = -1

# Default database name for ibase_connect().
default['xenforo']['php']['ibase']['default_db'] = nil

# Default username for ibase_connect().
default['xenforo']['php']['ibase']['default_user'] = nil

# Default password for ibase_connect().
default['xenforo']['php']['ibase']['default_password'] = nil

# Default charset for ibase_connect().
default['xenforo']['php']['ibase']['default_charset'] = nil

# Default timestamp format.
default['xenforo']['php']['ibase']['timestampformat'] = '%Y-%m-%d %H:%M:%S'

# Default date format.
default['xenforo']['php']['ibase']['dateformat'] = '%Y-%m-%d'

# Default time format.
default['xenforo']['php']['ibase']['timeformat'] = '%H:%M:%S'

# [MySQL]
# Allow accessing, from PHP's perspective, local files with LOAD DATA statements
# http://php.net/mysql.allow_local_infile
default['xenforo']['php']['mysql']['allow_local_infile'] = 'On'

# Allow or prevent persistent links.
# http://php.net/mysql.allow-persistent
default['xenforo']['php']['mysql']['allow_persistent'] = 'On'

# If mysqlnd is used: Number of cache slots for the internal result set cache
# http://php.net/mysql.cache_size
default['xenforo']['php']['mysql']['cache_size'] = 2000

# Maximum number of persistent links.  -1 means no limit.
# http://php.net/mysql.max-persistent
default['xenforo']['php']['mysql']['max_persistent'] = -1

# Maximum number of links (persistent + non-persistent).  -1 means no limit.
# http://php.net/mysql.max-links
default['xenforo']['php']['mysql']['max_links'] = -1

# Default port number for mysql_connect().  If unset, mysql_connect() will use
# the $MYSQL_TCP_PORT or the mysql-tcp entry in /etc/services or the
# compile-time value defined MYSQL_PORT (in that order).  Win32 will only look
# at MYSQL_PORT.
# http://php.net/mysql.default-port
default['xenforo']['php']['mysql']['default_port'] = ''

# Default socket name for local MySQL connects.  If empty, uses the built-in
# MySQL defaults.
# http://php.net/mysql.default-socket
default['xenforo']['php']['mysql']['default_socket'] = ''

# Default host for mysql_connect() (doesn't apply in safe mode).
# http://php.net/mysql.default-host
default['xenforo']['php']['mysql']['default_host'] = ''

# Default user for mysql_connect() (doesn't apply in safe mode).
# http://php.net/mysql.default-user
default['xenforo']['php']['mysql']['default_user'] = ''

# Default password for mysql_connect() (doesn't apply in safe mode).
# Note that this is generally a *bad* idea to store passwords in this file.
# *Any* user with PHP access can run 'echo get_cfg_var("mysql.default_password")
# and reveal this password!  And of course, any users with read access to this
# file will be able to reveal the password as well.
# http://php.net/mysql.default-password
default['xenforo']['php']['mysql']['default_password'] = ''

# Maximum time (in seconds) for connect timeout. -1 means no limit
# http://php.net/mysql.connect-timeout
default['xenforo']['php']['mysql']['connect_timeout'] = 60

# Trace mode. When trace_mode is active (=On), warnings for table/index scans and
# SQL-Errors will be displayed.
# http://php.net/mysql.trace-mode
default['xenforo']['php']['mysql']['trace_mode'] = 'Off'

# [MySQLi]

# Maximum number of persistent links.  -1 means no limit.
# http://php.net/mysqli.max-persistent
default['xenforo']['php']['mysqli']['max_persistent'] = -1

# Allow accessing, from PHP's perspective, local files with LOAD DATA statements
# http://php.net/mysqli.allow_local_infile
default['xenforo']['php']['mysqli']['allow_local_infile'] = nil

# Allow or prevent persistent links.
# http://php.net/mysqli.allow-persistent
default['xenforo']['php']['mysqli']['allow_persistent'] = 'On'

# Maximum number of links.  -1 means no limit.
# http://php.net/mysqli.max-links
default['xenforo']['php']['mysqli']['max_links'] = -1

# If mysqlnd is used: Number of cache slots for the internal result set cache
# http://php.net/mysqli.cache_size
default['xenforo']['php']['mysqli']['cache_size'] = 2000

# Default port number for mysqli_connect().  If unset, mysqli_connect() will use
# the $MYSQL_TCP_PORT or the mysql-tcp entry in /etc/services or the
# compile-time value defined MYSQL_PORT (in that order).  Win32 will only look
# at MYSQL_PORT.
# http://php.net/mysqli.default-port
default['xenforo']['php']['mysqli']['default_port'] = 3306

# Default socket name for local MySQL connects.  If empty, uses the built-in
# MySQL defaults.
# http://php.net/mysqli.default-socket
default['xenforo']['php']['mysqli']['default_socket'] = ''

# Default host for mysql_connect() (doesn't apply in safe mode).
# http://php.net/mysqli.default-host
default['xenforo']['php']['mysqli']['default_host'] = ''

# Default user for mysql_connect() (doesn't apply in safe mode).
# http://php.net/mysqli.default-user
default['xenforo']['php']['mysqli']['default_user'] = ''

# Default password for mysqli_connect() (doesn't apply in safe mode).
# Note that this is generally a *bad* idea to store passwords in this file.
# *Any* user with PHP access can run 'echo get_cfg_var("mysqli.default_pw")
# and reveal this password!  And of course, any users with read access to this
# file will be able to reveal the password as well.
# http://php.net/mysqli.default-pw
default['xenforo']['php']['mysqli']['default_pw'] = ''

# Allow or prevent reconnect
default['xenforo']['php']['mysqli']['reconnect'] = 'Off'

# [mysqlnd]
# Enable / Disable collection of general statistics by mysqlnd which can be
# used to tune and monitor MySQL operations.
# http://php.net/mysqlnd.collect_statistics
default['xenforo']['php']['mysqlnd']['collect_statistics'] = 'On'

# Enable / Disable collection of memory usage statistics by mysqlnd which can be
# used to tune and monitor MySQL operations.
# http://php.net/mysqlnd.collect_memory_statistics
default['xenforo']['php']['mysqlnd']['collect_memory_statistics'] = 'Off'

# Size of a pre-allocated buffer used when sending commands to MySQL in bytes.
# http://php.net/mysqlnd.net_cmd_buffer_size
default['xenforo']['php']['mysqlnd']['net_cmd_buffer_size'] = nil

# Size of a pre-allocated buffer used for reading data sent by the server in
# bytes.
# http://php.net/mysqlnd.net_read_buffer_size
default['xenforo']['php']['mysqlnd']['net_read_buffer_size'] = nil

# [OCI8]

# Connection: Enables privileged connections using external
# credentials (OCI_SYSOPER, OCI_SYSDBA)
# http://php.net/oci8.privileged-connect
default['xenforo']['php']['oci8']['privileged_connect'] = nil

# Connection: The maximum number of persistent OCI8 connections per
# process. Using -1 means no limit.
# http://php.net/oci8.max-persistent
default['xenforo']['php']['oci8']['max_persistent'] = nil

# Connection: The maximum number of seconds a process is allowed to
# maintain an idle persistent connection. Using -1 means idle
# persistent connections will be maintained forever.
# http://php.net/oci8.persistent-timeout
default['xenforo']['php']['oci8']['persistent_timeout'] = nil

# Connection: The number of seconds that must pass before issuing a
# ping during oci_pconnect() to check the connection validity. When
# set to 0, each oci_pconnect() will cause a ping. Using -1 disables
# pings completely.
# http://php.net/oci8.ping-interval
default['xenforo']['php']['oci8']['ping_interval'] = nil

# Connection: Set this to a user chosen connection class to be used
# for all pooled server requests with Oracle 11g Database Resident
# Connection Pooling (DRCP).  To use DRCP, this value should be set to
# the same string for all web servers running the same application,
# the database pool must be configured, and the connection string must
# specify to use a pooled server.
default['xenforo']['php']['oci8']['connection_class'] = nil

# High Availability: Using On lets PHP receive Fast Application
# Notification (FAN) events generated when a database node fails. The
# database must also be configured to post FAN events.
default['xenforo']['php']['oci8']['events'] = nil

# Tuning: This option enables statement caching, and specifies how
# many statements to cache. Using 0 disables statement caching.
# http://php.net/oci8.statement-cache-size
default['xenforo']['php']['oci8']['statement_cache_size'] = nil

# Tuning: Enables statement prefetching and sets the default number of
# rows that will be fetched automatically after statement execution.
# http://php.net/oci8.default-prefetch
default['xenforo']['php']['oci8']['default_prefetch'] = nil

# Compatibility. Using On means oci_close() will not close
# oci_connect() and oci_new_connect() connections.
# http://php.net/oci8.old-oci-close-semantics
default['xenforo']['php']['oci8']['old_oci_close_semantics'] = nil

# [PostgreSQL]
# Allow or prevent persistent links.
# http://php.net/pgsql.allow-persistent
default['xenforo']['php']['pgsql']['allow_persistent'] = 'On'

# Detect broken persistent links always with pg_pconnect().
# Auto reset feature requires a little overheads.
# http://php.net/pgsql.auto-reset-persistent
default['xenforo']['php']['pgsql']['auto_reset_persistent'] = 'Off'

# Maximum number of persistent links.  -1 means no limit.
# http://php.net/pgsql.max-persistent
default['xenforo']['php']['pgsql']['max_persistent'] = -1

# Maximum number of links (persistent+non persistent).  -1 means no limit.
# http://php.net/pgsql.max-links
default['xenforo']['php']['pgsql']['max_links'] = -1

# Ignore PostgreSQL backends Notice message or not.
# Notice message logging require a little overheads.
# http://php.net/pgsql.ignore-notice
default['xenforo']['php']['pgsql']['ignore_notice'] = 0

# Log PostgreSQL backends Notice message or not.
# Unless pgsql.ignore_notice=0, module cannot log notice message.
# http://php.net/pgsql.log-notice
default['xenforo']['php']['pgsql']['log_notice'] = 0

# [Sybase-CT]
# Allow or prevent persistent links.
# http://php.net/sybct.allow-persistent
default['xenforo']['php']['sybct']['allow_persistent'] = 'On'

# Maximum number of persistent links.  -1 means no limit.
# http://php.net/sybct.max-persistent
default['xenforo']['php']['sybct']['max_persistent'] = -1

# Maximum number of links (persistent + non-persistent).  -1 means no limit.
# http://php.net/sybct.max-links
default['xenforo']['php']['sybct']['max_links'] = -1

# Minimum server message severity to display.
# http://php.net/sybct.min-server-severity
default['xenforo']['php']['sybct']['min_server_severity'] = 10

# Minimum client message severity to display.
# http://php.net/sybct.min-client-severity
default['xenforo']['php']['sybct']['min_client_severity'] = 10

# Set per-context timeout
# http://php.net/sybct.timeout
default['xenforo']['php']['sybct']['timeout'] = nil

# sybct.packet_size

# The maximum time in seconds to wait for a connection attempt to succeed before returning failure.
# Default: one minute
default['xenforo']['php']['sybct']['login_timeout'] = nil

# The name of the host you claim to be connecting from, for display by sp_who.
# Default: none
default['xenforo']['php']['sybct']['hostname'] = nil

# Allows you to define how often deadlocks are to be retried. -1 means "forever".
# Default: 0
default['xenforo']['php']['sybct']['deadlock_retry_count'] = nil

# [bcmath]
# Number of decimal digits for all bcmath functions.
# http://php.net/bcmath.scale
default['xenforo']['php']['bcmath']['scale'] = 0

# [browscap]
# http://php.net/browscap
default['xenforo']['php']['browscap'] = nil

# [Session]
# Handler used to store/retrieve data.
# http://php.net/session.save-handler
default['xenforo']['php']['session']['save_handler'] = 'files'

# Argument passed to save_handler.  In the case of files, this is the path
# where data files are stored. Note: Windows users have to change this
# variable in order to use PHP's session functions.
#
# The path can be defined as:
#
#     session.save_path = "N#/path"
#
# where N is an integer.  Instead of storing all the session files in
# /path, what this will do is use subdirectories N-levels deep, and
# store the session data in those directories.  This is useful if you
# or your OS have problems with lots of files in one directory, and is
# a more efficient layout for servers that handle lots of sessions.
#
# NOTE 1: PHP will not create this directory structure automatically.
#         You can use the script in the ext/session dir for that purpose.
# NOTE 2: See the section on garbage collection below if you choose to
#         use subdirectories for session storage
#
# The file storage module creates files using mode 600 by default.
# You can change that by using
#
#     session.save_path = "N#MODE#/path"
#
# where MODE is the octal representation of the mode. Note that this
# does not overwrite the process's umask.
# http://php.net/session.save-path
default['xenforo']['php']['session']['save_path'] = "#{node['apache']['docroot_dir']}/#{node['xenforo']['name']}-sessions"

# Whether to use cookies.
# http://php.net/session.use-cookies
default['xenforo']['php']['session']['use_cookies'] = 1

# http://php.net/session.cookie-secure
default['xenforo']['php']['session']['cookie_secure'] = nil

# This option forces PHP to fetch and use a cookie for storing and maintaining
# the session id. We encourage this operation as it's very helpful in combating
# session hijacking when not specifying and managing your own session id. It is
# not the end all be all of session hijacking defense, but it's a good start.
# http://php.net/session.use-only-cookies
default['xenforo']['php']['session']['use_only_cookies'] = 1

# Name of the session (used as cookie name).
# http://php.net/session.name
default['xenforo']['php']['session']['name'] = 'PHPSESSID'

# Initialize session on request startup.
# http://php.net/session.auto-start
default['xenforo']['php']['session']['auto_start'] = 0

# Lifetime in seconds of cookie or, if 0, until browser is restarted.
# http://php.net/session.cookie-lifetime
default['xenforo']['php']['session']['cookie_lifetime'] = 0

# The path for which the cookie is valid.
# http://php.net/session.cookie-path
default['xenforo']['php']['session']['cookie_path'] = '/'

# The domain for which the cookie is valid.
# http://php.net/session.cookie-domain
default['xenforo']['php']['session']['cookie_domain'] = ''

# Whether or not to add the httpOnly flag to the cookie, which makes
# it inaccessible to browser scripting languages such as JavaScript.
# http://php.net/session.cookie-httponly
default['xenforo']['php']['session']['cookie_httponly'] = ''

# Handler used to serialize data.  php is the standard serializer of PHP.
# http://php.net/session.serialize-handler
default['xenforo']['php']['session']['serialize_handler'] = 'php'

# Defines the probability that the 'garbage collection' process is started
# on every session initialization. The probability is calculated by using
# gc_probability/gc_divisor. Where session.gc_probability is the numerator
# and gc_divisor is the denominator in the equation. Setting this value to 1
# when the session.gc_divisor value is 100 will give you approximately a 1% chance
# the gc will run on any give request.
# Default Value: 1
# Development Value: 1
# Production Value: 1
# http://php.net/session.gc-probability
default['xenforo']['php']['session']['gc_probability'] = 0

# Defines the probability that the 'garbage collection' process is started on every
# session initialization. The probability is calculated by using the following equation:
# gc_probability/gc_divisor. Where session.gc_probability is the numerator and
# session.gc_divisor is the denominator in the equation. Setting this value to 1
# when the session.gc_divisor value is 100 will give you approximately a 1% chance
# the gc will run on any give request. Increasing this value to 1000 will give you
# a 0.1% chance the gc will run on any give request. For high volume production servers,
# this is a more efficient approach.
# Default Value: 100
# Development Value: 1000
# Production Value: 1000
# http://php.net/session.gc-divisor
default['xenforo']['php']['session']['gc_divisor'] = 1000

# After this number of seconds, stored data will be seen as 'garbage' and
# cleaned up by the garbage collection process.
# http://php.net/session.gc-maxlifetime
default['xenforo']['php']['session']['gc_maxlifetime'] = 1440

# NOTE: If you are using the subdirectory option for storing session files
#       (see session.save_path above), then garbage collection does *not*
#       happen automatically.  You will need to do your own garbage
#       collection through a shell script, cron entry, or some other method.
#       For example, the following script would is the equivalent of
#       setting session.gc_maxlifetime to 1440 (1440 seconds = 24 minutes):
#          find /path/to/sessions -cmin +24 | xargs rm

# PHP 4.2 and less have an undocumented feature/bug that allows you to
# to initialize a session variable in the global scope.
# PHP 4.3 and later will warn you, if this feature is used.
# You can disable the feature and the warning separately. At this time,
# the warning is only displayed, if bug_compat_42 is enabled. This feature
# introduces some serious security problems if not handled correctly. It's
# recommended that you do not use this feature on production servers. But you
# should enable this on development servers and enable the warning as well. If you
# do not enable the feature on development servers, you won't be warned when it's
# used and debugging errors caused by this can be difficult to track down.
# Default Value: On
# Development Value: On
# Production Value: Off
# http://php.net/session.bug-compat-42
default['xenforo']['php']['session']['bug_compat_42'] = 'Off'

# This setting controls whether or not you are warned by PHP when initializing a
# session value into the global space. session.bug_compat_42 must be enabled before
# these warnings can be issued by PHP. See the directive above for more information.
# Default Value: On
# Development Value: On
# Production Value: Off
# http://php.net/session.bug-compat-warn
default['xenforo']['php']['session']['bug_compat_warn'] = 'Off'

# Check HTTP Referer to invalidate externally stored URLs containing ids.
# HTTP_REFERER has to contain this substring for the session to be
# considered as valid.
# http://php.net/session.referer-check
default['xenforo']['php']['session']['referer_check'] = ''

# How many bytes to read from the file.
# http://php.net/session.entropy-length
default['xenforo']['php']['session']['entropy_length'] = nil

# Specified here to create the session id.
# http://php.net/session.entropy-file
# Defaults to /dev/urandom
# On systems that don't have /dev/urandom but do have /dev/arandom,
# this will default to /dev/arandom
# If neither are found at compile time, the default is no entropy file.
# On windows, setting the entropy_length setting will activate the
# Windows random source (using the CryptoAPI)
default['xenforo']['php']['session']['entropy_file'] = nil

# Set to {nocache,private,public,} to determine HTTP caching aspects
# or leave this empty to avoid sending anti-caching headers.
# http://php.net/session.cache-limiter
default['xenforo']['php']['session']['cache_limiter'] = 'nocache'

# Document expires after n minutes.
# http://php.net/session.cache-expire
default['xenforo']['php']['session']['cache_expire'] = 180

# trans sid support is disabled by default.
# Use of trans sid may risk your users security.
# Use this option with caution.
# - User may send URL contains active session ID
#   to other person via. email/irc/etc.
# - URL that contains active session ID may be stored
#   in publicly accessible computer.
# - User may access your site with the same session ID
#   always using URL stored in browser's history or bookmarks.
# http://php.net/session.use-trans-sid
default['xenforo']['php']['session']['use_trans_sid'] = 0

# Select a hash function for use in generating session ids.
# Possible Values
#   0  (MD5 128 bits)
#   1  (SHA-1 160 bits)
# This option may also be set to the name of any hash function supported by
# the hash extension. A list of available hashes is returned by the hash_algos()
# function.
# http://php.net/session.hash-function
default['xenforo']['php']['session']['hash_function'] = 0

# Define how many bits are stored in each character when converting
# the binary hash data to something readable.
# Possible values:
#   4  (4 bits: 0-9, a-f)
#   5  (5 bits: 0-9, a-v)
#   6  (6 bits: 0-9, a-z, A-Z, "-", ",")
# Default Value: 4
# Development Value: 5
# Production Value: 5
# http://php.net/session.hash-bits-per-character
default['xenforo']['php']['session']['hash_bits_per_character'] = 5

# The URL rewriter will look for URLs in a defined set of HTML tags.
# form/fieldset are special# if you include them here, the rewriter will
# add a hidden <input> field with the info which is otherwise appended
# to URLs.  If you want XHTML conformity, remove the form entry.
# Note that all valid entries require a "=", even if no value follows.
# Default Value: "a=href,area=href,frame=src,form=,fieldset="
# Development Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
# Production Value: "a=href,area=href,frame=src,input=src,form=fakeentry"
# http://php.net/url-rewriter.tags
default['xenforo']['php']['url_rewriter']['tags'] = \
'a=href,area=href,frame=src,input=src,form=fakeentry'

# Enable upload progress tracking in $_SESSION
# Default Value: On
# Development Value: On
# Production Value: On
# http://php.net/session.upload-progress.enabled
default['xenforo']['php']['session']['upload_progress']['enabled'] = nil

# Cleanup the progress information as soon as all POST data has been read
# (i.e. upload completed).
# Default Value: On
# Development Value: On
# Production Value: On
# http://php.net/session.upload-progress.cleanup
default['xenforo']['php']['session']['upload_progress']['cleanup'] = nil

# A prefix used for the upload progress key in $_SESSION
# Default Value: "upload_progress_"
# Development Value: "upload_progress_"
# Production Value: "upload_progress_"
# http://php.net/session.upload-progress.prefix
default['xenforo']['php']['session']['upload_progress']['prefix'] = nil

# The index name (concatenated with the prefix) in $_SESSION
# containing the upload progress information
# Default Value: "PHP_SESSION_UPLOAD_PROGRESS"
# Development Value: "PHP_SESSION_UPLOAD_PROGRESS"
# Production Value: "PHP_SESSION_UPLOAD_PROGRESS"
# http://php.net/session.upload-progress.name
default['xenforo']['php']['session']['upload_progress']['name'] = nil

# How frequently the upload progress should be updated.
# Given either in percentages (per-file), or in bytes
# Default Value: "1%"
# Development Value: "1%"
# Production Value: "1%"
# http://php.net/session.upload-progress.freq
default['xenforo']['php']['session']['upload_progress']['freq'] = nil

# The minimum delay between updates, in seconds
# Default Value: 1
# Development Value: 1
# Production Value: 1
# http://php.net/session.upload-progress.min-freq
default['xenforo']['php']['session']['upload_progress']['min_freq'] = nil

# [MSSQL]
# Allow or prevent persistent links.
default['xenforo']['php']['mssql']['allow_persistent'] = 'On'

# Maximum number of persistent links.  -1 means no limit.
default['xenforo']['php']['mssql']['max_persistent'] = -1

# Maximum number of links (persistent+non persistent).  -1 means no limit.
default['xenforo']['php']['mssql']['max_links'] = -1

# Minimum error severity to display.
default['xenforo']['php']['mssql']['min_error_severity'] = 10

# Minimum message severity to display.
default['xenforo']['php']['mssql']['min_message_severity'] = 10

# Compatibility mode with old versions of PHP 3.0.
default['xenforo']['php']['mssql']['compatability_mode'] = 'Off'

# Connect timeout
default['xenforo']['php']['mssql']['connect_timeout'] = nil

# Query timeout
default['xenforo']['php']['mssql']['timeout'] = nil

# Valid range 0 - 2147483647.  Default = 4096.
default['xenforo']['php']['mssql']['textlimit'] = nil

# Valid range 0 - 2147483647.  Default = 4096.
default['xenforo']['php']['mssql']['textsize'] = nil

# Limits the number of records in each batch.  0 = all records in one batch.
default['xenforo']['php']['mssql']['batchsize'] = nil

# Specify how datetime and datetim4 columns are returned
# On => Returns data converted to SQL server settings
# Off => Returns values as YYYY-MM-DD hh:mm:ss
default['xenforo']['php']['mssql']['datetimeconvert'] = nil

# Use NT authentication when connecting to the server
default['xenforo']['php']['mssql']['secure_connection'] = 'Off'

# Specify max number of processes. -1 = library default
# msdlib defaults to 25
# FreeTDS defaults to 4096
default['xenforo']['php']['mssql']['max_procs'] = nil

# Specify client character set.
# If empty or not set the client charset from freetds.conf is used
# This is only used when compiled with FreeTDS
default['xenforo']['php']['mssql']['charset'] = nil

# [Assertion]
# Assert(expr)# active by default.
# http://php.net/assert.active
default['xenforo']['php']['assert']['active'] = nil

# Issue a PHP warning for each failed assertion.
# http://php.net/assert.warning
default['xenforo']['php']['assert']['warning'] = nil

# Don't bail out by default.
# http://php.net/assert.bail
default['xenforo']['php']['assert']['bail'] = nil

# User-function to be called if an assertion fails.
# http://php.net/assert.callback
default['xenforo']['php']['assert']['callback'] = nil

# Eval the expression with current error_reporting().  Set to true if you want
# error_reporting(0) around the eval().
# http://php.net/assert.quiet-eval
default['xenforo']['php']['assert']['quiet_eval'] = nil

# [COM]
# path to a file containing GUIDs, IIDs or filenames of files with TypeLibs
# http://php.net/com.typelib-file
default['xenforo']['php']['com']['typelib_file'] = nil

# allow Distributed-COM calls
# http://php.net/com.allow-dcom
default['xenforo']['php']['com']['allow_dcom'] = nil

# autoregister constants of a components typlib on com_load()
# http://php.net/com.autoregister-typelib
default['xenforo']['php']['com']['autoregister_typelib'] = nil

# register constants casesensitive
# http://php.net/com.autoregister-casesensitive
default['xenforo']['php']['com']['autoregister_casesensitive'] = nil

# show warnings on duplicate constant registrations
# http://php.net/com.autoregister-verbose
default['xenforo']['php']['com']['autoregister_verbose'] = nil

# The default character set code-page to use when passing strings to and from COM objects.
# Default: system ANSI code page
default['xenforo']['php']['com']['code_page'] = nil

# [mbstring]
# language for internal character representation.
# http://php.net/mbstring.language
default['xenforo']['php']['mbstring']['language'] = nil

# internal/script encoding.
# Some encoding cannot work as internal encoding.
# (e.g. SJIS, BIG5, ISO-2022-*)
# http://php.net/mbstring.internal-encoding
default['xenforo']['php']['mbstring']['internal_encoding'] = nil

# http input encoding.
# http://php.net/mbstring.http-input
default['xenforo']['php']['mbstring']['http_input'] = nil

# http output encoding. mb_output_handler must be
# registered as output buffer to function
# http://php.net/mbstring.http-output
default['xenforo']['php']['mbstring']['http_output'] = nil

# enable automatic encoding translation according to
# mbstring.internal_encoding setting. Input chars are
# converted to internal encoding by setting this to On.
# Note: Do _not_ use automatic encoding translation for
#       portable libs/applications.
# http://php.net/mbstring.encoding-translation
default['xenforo']['php']['mbstring']['encoding_translation'] = nil

# automatic encoding detection order.
# auto means
# http://php.net/mbstring.detect-order
default['xenforo']['php']['mbstring']['detect_order'] = nil

# substitute_character used when character cannot be converted
# one from another
# http://php.net/mbstring.substitute-character
default['xenforo']['php']['mbstring']['substitute_character'] = nil

# overload(replace) single byte functions by mbstring functions.
# mail(), ereg(), etc are overloaded by mb_send_mail(), mb_ereg(),
# etc. Possible values are 0,1,2,4 or combination of them.
# For example, 7 for overload everything.
# 0: No overload
# 1: Overload mail() function
# 2: Overload str*() functions
# 4: Overload ereg*() functions
# http://php.net/mbstring.func-overload
default['xenforo']['php']['mbstring']['func_overload'] = nil

# enable strict encoding detection.
default['xenforo']['php']['mbstring']['strict_detection'] = nil

# This directive specifies the regex pattern of content types for which mb_output_handler()
# is activated.
# Default: mbstring.http_output_conv_mimetype=^(text/|application/xhtml\+xml)
default['xenforo']['php']['mbstring']['http_output_conv_mimetype'] = nil

# [gd]
# Tell the jpeg decode to ignore warnings and try to create
# a gd image. The warning will then be displayed as notices
# disabled by default
# http://php.net/gd.jpeg-ignore-warning
default['xenforo']['php']['gd']['jpeg_ignore_warning'] = nil

# [exif]
# Exif UNICODE user comments are handled as UCS-2BE/UCS-2LE and JIS as JIS.
# With mbstring support this will automatically be converted into the encoding
# given by corresponding encode setting. When empty mbstring.internal_encoding
# is used. For the decode settings you can distinguish between motorola and
# intel byte order. A decode setting cannot be empty.
# http://php.net/exif.encode-unicode
default['xenforo']['php']['exif']['encode_unicode'] = nil

# http://php.net/exif.decode-unicode-motorola
default['xenforo']['php']['exif']['decode_unicode_motorola'] = nil

# http://php.net/exif.decode-unicode-intel
default['xenforo']['php']['exif']['decode_unicode_intel'] = nil

# http://php.net/exif.encode-jis
default['xenforo']['php']['exif']['encode_jis'] = nil

# http://php.net/exif.decode-jis-motorola
default['xenforo']['php']['exif']['decode_jis_motorola'] = nil

# http://php.net/exif.decode-jis-intel
default['xenforo']['php']['exif']['decode_jis_intel'] = nil

# [Tidy]
# The path to a default tidy configuration file to use when using tidy
# http://php.net/tidy.default-config
default['xenforo']['php']['tidy']['default_config'] = nil

# Should tidy clean and repair output automatically?
# WARNING: Do not use this option if you are generating non-html content
# such as dynamic images
# http://php.net/tidy.clean-output
default['xenforo']['php']['tidy']['clean_output'] = 'Off'

# [soap]
# Enables or disables WSDL caching feature.
# http://php.net/soap.wsdl-cache-enabled
default['xenforo']['php']['soap']['wsdl_cache_enabled'] = 1

# Sets the directory name where SOAP extension will put cache files.
# http://php.net/soap.wsdl-cache-dir
default['xenforo']['php']['soap']['wsdl_cache_dir'] = '/tmp'

# (time to live) Sets the number of second while cached file will be used
# instead of original one.
# http://php.net/soap.wsdl-cache-ttl
default['xenforo']['php']['soap']['wsdl_cache_ttl'] = 86_400

# Sets the size of the cache limit. (Max. number of WSDL files to cache)
default['xenforo']['php']['soap']['wsdl_cache_limit'] = 5

# [sysvshm]
# A default size of the shared memory segment
default['xenforo']['php']['sysvshm']['init_mem'] = nil

# [ldap]
# Sets the maximum number of open links or -1 for unlimited.
default['xenforo']['php']['ldap']['max_links'] = -1

# [mcrypt]
# For more information about mcrypt settings see http://php.net/mcrypt-module-open

# Directory where to load mcrypt algorithms
# Default: Compiled in into libmcrypt (usually /usr/local/lib/libmcrypt)
default['xenforo']['php']['mcrypt']['algorithms_dir'] = nil

# Directory where to load mcrypt modes
# Default: Compiled in into libmcrypt (usually /usr/local/lib/libmcrypt)
default['xenforo']['php']['mcrypt']['modes_dir'] = nil

# [dba]
default['xenforo']['php']['dba']['default_handler'] = nil

# Local Variables:
# tab-width: 4
# End:
