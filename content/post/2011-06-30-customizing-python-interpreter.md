---
title:  "Customizing the Python Interpreter"
date:   2011-06-30 07:20:05
---

I was working with a friend on debugging an odd pickling issue. In order to
really play with it, we started a Python interpreter and ran through the list
of imports and sys.path.appends necessary to set up active database and
memcache connections, as well as load the project code.

My friend mentioned that he had a python session on his desktop that he never
dared to close, since the setup had been so much trouble.

Thinking that it would be great to have this more frequently, and more easily,
I created a python file which gets loaded every time I start my python
interpreter, pyprompt.py.

```python
import sys
import os

def getProjectDir(d=os.getcwd()):
    projects = os.path.join(os.environ['HOME'], "projects")
    if os.path.dirname(d) in ['/home', '/']:
        return None
    elif projects == os.path.dirname(d):
        if os.path.exists(os.path.join(d, "src/pylons/proj")):
            return d
        else:
            return None
    else:
        return getProjectDir(os.path.dirname(d))

pd = getProjectDir()
if pd:
    print
    print "Detected %s project. Setting up database." %(os.path.basename(pd))
    print
    sys.path.append(os.path.join(pd, "src/pylons/proj"))
    import proj
    from proj.lib.helpers import setup_db
    factory = setup_db()
    dbcon = factory.getConnection()
```

Now I want this file to run every time the python interpreter is started.

```sh
export PYTHONSTARTUP="/home/jsimpson/bin/pyprompt.py"
```


So, what happens is, when the python interpreter starts, it checks the
`PYTHONSTARTUP` variable for a python file to run. That executes the
`getProjectDir()` function, which tests if my current working directory is in a
project. (Our workflow includes many branches of the main project.) If I am in
a project, it will import the files from that project and setup my interpreter,
ready for some interactive work.

