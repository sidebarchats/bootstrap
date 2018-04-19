
# Developer Magical Setup One-liner:

```bash
bash <(curl -s https://raw.githubusercontent.com/sidebarchats/meta/master/bootstrap.sh)
```

This will run our setup script, prompting you before it does anything, and broadly just downloads the sidebar codebases, and makes sure you've got the required languages and libraries installed.  Uses nvm, virtualenv, and best practices to keep your system clean.

While it's running,

# Grok the system

Here is the [Overall Schema, Users, Apps, and Data Flow](https://github.com/sidebarchats/meta/wiki/Overall-Schema-and-Data-Flow).  Please grok it, and raise any questions in slack!


# Get hacking.

Getting started hacking on any of our codebases is as easy as:

```
d workon <repo_name>
d setup  # the first time only.
d up
```


# Ok, get hacking *properly*.

You'll really want to do stuff like this:

```
d workon app
d sync
d setup
d nb my_cool_feature
d up
```



