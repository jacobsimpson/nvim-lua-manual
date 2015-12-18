---
layout: post
title:  "Logging to syslogd from Python"
date:   2012-05-02 01:09:00
categories: python
---

On Unix there is a syslog service that handles centralized logging. Using it
for logging from your daemons has the advantage of putting control of the
logging options in the hands of the system administrator, without involving
you, the developer. If they want certain log rotations, or there is a preferred
directory, or if the logs are sent over the network to a central logging
server, it has nothing to do with you, as long as you are logging to syslog.

First off, you need a config file something like this:

{% highlight python %}
[loggers]
keys=mysyslogger_l

[handlers]
keys=mysyslogger_h

[formatters]
keys=mysyslogger_f

[logger_mysyslogger_l]
level=NOTSET
handlers=mysyslogger_h
propagate=0

[handler_mysyslogger_h]
# Add this line to syslog.conf
# local1.*         /var/log/distributor.log
level=NOTSET
formatter=mysyslogger_f
class=handlers.SysLogHandler
args=('/dev/log', handlers.SysLogHandler.LOG_LOCAL1)

[formatter_mysyslogger_f]
format=%(message)s
{% endhighlight %}

Then, you'll need to read that config file with your Python program:

{% highlight python %}
import logging
import logging.config

logging.config.fileConfig("logging.conf")
log = logging.getLogger("mysyslogger_l")
log.info("This an info message.")
log.error("This is an error message.")
{% endhighlight %}

Then you'll probably need to configure your syslog to write the messages somewhere. Add this line to /etc/syslog.conf and run /etc/init.d/syslog restart:

{% highlight python %}
local1.*         /var/log/mysyslog_file.log
{% endhighlight %}
