---
title:  "Unified Jar"
date:   2015-12-20 09:23:07
---

Sometimes I have a little program built in some JVM language. Usually it's a
simple command line utility, maybe something that tests database connectivity
via a JDBC connection, a simple JMS utility or a utility analogous to ping but
for UDP.

The point is, I want to make it easy to set it up and move it from machine to
machine.  I just want to run it from the command line and have it work.

But, it's got several code files, maybe a resource, and I used something for a
network library, and a command line parsing library...

What I would like is a consolidated jar, one jar that has what is needed, it is
configured so it can be run with `java -jar Util.jar`, and it will work.

Obviously, the build system should be responsible for producing the new
consolidated artifact.

For the simplest version, where there are only code files, no jars, it's pretty
straight forward:

```xml
<target name="dist" depends="compile"
        description="generate the distribution" >
    <!-- Create the distribution directory -->
    <mkdir dir="${dist}"/>

    <jar jarfile="${dist}/Util.jar" basedir="${build}">
        <manifest>
            <attribute name="Main-Class" value="Main"/>
        </manifest>
    </jar>
</target>
```

Next, say there I used some libraries, something for parsing command line parameters.

There are two basic approaches to this. One is to create a jar containing jars.
A custom class loader that knows how to read jars from inside jars is required
to make this work. There are a couple available tools that do this. Eclipse can
do this through the GUI or [One Jar](http://one-jar.sourceforge.net/).

This repo covers (but does not necessarily advocate) a second approach.
Unjarring the libraries and creating a new jar with all the classes from the
compile and the libraries in a single jar.

Adding this line:

```xml
<zipfileset src="lib/commons-cli-1.3.1.jar" includes="**/*.class"/>
```

will unzip the library jar, extract the .class files and include them the new
jar that is being created. In context it looks like this:

```xml
<target name="dist" depends="compile">
   <mkdir dir="${dist}"/>

   <jar jarfile="${dist}/util.jar" basedir="${classes}">
        <manifest>
            <attribute name="Main-Class" value="Main"/>
        </manifest>
        <zipfileset src="lib/commons-cli-1.3.1.jar" includes="**/*.class"/>
    </jar>
</target>
```

Now there is a single jar that contains all the dependencies necessary to run
the program.

There is an additional evolution possible. On Unix style systems it is possible
to create a single consolidated file that can be set executable.

By taking a simple bash script:

```sh
#! /bin/bash

exec /usr/bin/java -jar $0 "$@"
```

and munging that on the beginning of a jar file, the result is a file that will
execute on its own, as long as there is a /usr/bin/java executable installed.

By adding these lines to the Ant task, a concatenated file with the script and
jar will be created.

```xml
<concat destfile="${build}/util" binary="yes">
    <filelist dir="src/main/bash" files="header.sh"/>
    <filelist dir="${dist}" files="util.jar"/>
</concat>
<chmod file="${build}/util" perm="ugo+x"/>
```

A sample project is available
[here](https://github.com/jacobsimpson/consolidated_jar/tree/ant-build).

