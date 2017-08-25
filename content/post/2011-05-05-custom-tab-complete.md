---
title:  "Custom Tab Complete and Bash Functions"
date:   2011-05-05 00:42:05
draft: false
---

Everyone with even a little experience in Unix has their own special aliases.
Maybe you have:

```sh
alias cdw="cd ~/workspace"
```

to take you to the directory where you have your projects. Maybe you have some
really sophisticated aliases that change your bash configuration and path when
you hit a certain directory.

One of the challenges I found when I moved off of csh to bash was csh aliases
had parameters, so you could make niffty aliases that had some value in the
middle:

```sh
alias fi 'find . -name \!:1 -exec vim {} \;'
```

(The first alias I ever used, from my friend William Hui). Using this alias, if
you run:

```sh
fi mycode.c
```

It will search through the directory tree to find mycode.c and open it in vim.
Bash doesn't seem to give you the same level of control over alias parameters.
However, recently I've learned that you can create a bash function, and it will
run like a command on the command line.

Since fi is a reserved word that closes an if statement in bash, we'll switch
from fi to fim. Then create this in a file (functions.sh):

```sh
fim() {
    test ! -z "$1" && find . -name $1 -exec vim {} \;
}
```

and source the file in your current environment:

```sh
source functions.sh
```

then this works in bash:

```sh
fim mycode.c
```

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

```sh
wcd() {
    cd ~/workspace
}
```

That's cool, anywhere you are

```sh
wcd
```

takes you there. However, now that it's a bash function, it's really straight
forward to augment it a little:

```sh
wcd() {
    cd ~/workspace/$1
}
```

That's cool too. Now, assuming your working directory looks like this:

```sh
[jsimpson@jsimpson-lnx1 workspace]$ ls
bookcatalog/  mashup/  mywebsite/  out.html
```

you can:

```sh
wcd bookcatalog
```

and anywhere you are will take you to ~/workspace/bookcatalog. However, if your
workspace looks like mine, it has many projects, some of which haven't been
worked on in months or years. Sometimes I need a little help to remember where
I'm going. Wouldn't a custom tab complete be great?

```sh
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
```

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

```sh
wcd m
```

When you hit tab, the function will run and evaluate like this:

```sh
cur="m"
opts="bookcatalog mashup mywebsite"
COMPREPLY=(mashup mywebsite)
```

and on the command line you will see this:

```sh
[jsimpson@jsimpson-lnx1 workspace]$ wcd m
mashup     mywebsite
```

[Debian Administrator's Introduction to Bash Completion](http://www.debian-administration.org/article/316/An_introduction_to_bash_completion_part_1)

