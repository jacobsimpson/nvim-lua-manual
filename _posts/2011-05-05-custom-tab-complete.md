---
layout: post
title:  "Custom Tab Complete and Bash Functions"
date:   2011-05-05 00:42:05
categories: bash
---

Everyone with even a little experience in Unix has their own special aliases.
Maybe you have:

{% highlight bash %}
alias cdw="cd ~/workspace"
{% endhighlight %}

to take you to the directory where you have your projects. Maybe you have some
really sophisticated aliases that change your bash configuration and path when
you hit a certain directory.

One of the challenges I found when I moved off of csh to bash was csh aliases
had parameters, so you could make niffty aliases that had some value in the
middle:

{% highlight bash %}
alias fi 'find . -name \!:1 -exec vim {} \;'
{% endhighlight %}

(The first alias I ever used, from my friend William Hui). Using this alias, if
you run:

{% highlight bash %}
fi mycode.c
{% endhighlight %}

It will search through the directory tree to find mycode.c and open it in vim.
Bash doesn't seem to give you the same level of control over alias parameters.
However, recently I've learned that you can create a bash function, and it will
run like a command on the command line.

Since fi is a reserved word that closes an if statement in bash, we'll switch
from fi to fim. Then create this in a file (functions.sh):

{% highlight bash %}
fim() {
    test ! -z "$1" && find . -name $1 -exec vim {} \;
}
{% endhighlight %}

and source the file in your current environment:

{% highlight bash %}
source functions.sh
{% endhighlight %}

then this works in bash:

{% highlight bash %}
fim mycode.c
{% endhighlight %}

Since you are now using a bash function instead of an alias, you can squeeze
any amount of bash code you want in there, format it nicely, even (possibly)
comment it. Aliases can get pretty crazy sometimes but a bash function should
be fairly readable.

So, that's cool, flexible bash functions instead of aliases. Which brings me to
my next trick. Everyone loves tab completion. Okay, that may be a fairly
sweeping statement, but watching people use the Unix command line, I think I
can safely say most people love tab completion.

With newer versions of bash, you can build your own custom tab completion. Lets
say you have a directory where you do a lot of your work, and you often want to
go there to some project.

{% highlight bash %}
wcd() {
    cd ~/workspace
}
{% endhighlight %}

That's cool, anywhere you are

{% highlight bash %}
wcd
{% endhighlight %}

takes you there. However, now that it's a bash function, it's really straight
forward to augment it a little:

{% highlight bash %}
wcd() {
    cd ~/workspace/$1
}
{% endhighlight %}

That's cool too. Now, assuming your working directory looks like this:

{% highlight bash %}
[jsimpson@jsimpson-lnx1 workspace]$ ls
bookcatalog/  mashup/  mywebsite/  out.html
{% endhighlight %}

you can:

{% highlight bash %}
wcd bookcatalog
{% endhighlight %}

and anywhere you are will take you to ~/workspace/bookcatalog. However, if your
workspace looks like mine, it has many projects, some of which haven't been
worked on in months or years. Sometimes I need a little help to remember where
I'm going. Wouldn't a custom tab complete be great?

{% highlight bash %}
wcd() {
    cd ~/workspace/$1
}

_wcd() {
    local cur opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=$(cd ~/workspace ; ls -d */. | sed 's|/./||')
    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
}
complete -F _wcd wcd
{% endhighlight %}

The first function we've seen before. Once you press enter on the command line,
this is the function that will do the work of changing you to a new directory.

Last line first, complete is a utility that registers a function (-F for
function) to be run every time you tab when wcd is the first command on the
command line.

_wcd is the function that computes your list of possible completions.

local - sets up some local variables.

cur - gets the last element of the COMP_WORDS array, which is a special bash
variable that holds the array of parameters to the command line you are
pressing tab on.

opts - this line gets a string of space delimited words that are possible
completions, something that will look like this "dir1 dir2 dir3".

COMPREPLY - this is a special bash variable that is an array of all the
possible completions. So, if you are here:

{% highlight bash %}
wcd m
{% endhighlight %}

When you hit tab, the function will run and evaluate like this:

{% highlight bash %}
cur="m"
opts="bookcatalog mashup mywebsite"
COMPREPLY=(mashup mywebsite)
{% endhighlight %}

and on the command line you will see this:

{% highlight bash %}
[jsimpson@jsimpson-lnx1 workspace]$ wcd m
mashup     mywebsite
{% endhighlight %}

[Debian Administrator's Introduction to Bash Completion](http://www.debian-administration.org/article/316/An_introduction_to_bash_completion_part_1)

