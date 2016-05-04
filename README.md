# heroku-buildpack-configurator

This build pack wraps up a simple AWK script that is capable of doing a naive
search-replace on any file in your Heroku slug, so you can change arbitrary
values during the build process.

## Install

This buildpack doesn't do a whole lot on its own, and is meant to be used in conjunction with another buildpack. So assuming you've got a heroku app already configured with a buildpack, do this:

    $ heroku buildpacks:add --index 1 https://github.com/imipolexg/heroku-buildpack-configurator

Then, before your next build, set the `CONFIGURATOR` variable to point to a
config file, as described next.

## Configuring configurator

It takes a very simple, (and strictly formatted!) configuration file that is
made of up lines like this:

    file_name replace-this-string=with-this-string replace-this-other-string=with-this-other-string another=with-another

This configuration file will edit the file `file_name` and replace all
occurences of `replace-this-string` with `with-this-string`, and
`replace-this-other-string=with-this-other-string` etc. The filename must be
the first field, followed by a space, followed by a `KEY=VALUE` pair. There can
be no spaces in the whole of the `KEY=VALUE` pair (I realize this reduces the
usefulness of the script and plan to remove this restriction in a later
version, for now this suffices for my own purposes).

In order to find the configuration file, the buildpack expects the environment
variable `CONFIGURATOR` to contain the (relative) path of the configuration
file.

    $ heroku config:set CONFIGURATOR=conf/configurator.conf

This means, importantly, that it is possible to have different configurations
for different deployments of your heroku app. So for example for your
development deployment you could do:

    $ heroku config:set CONFIGURATOR=conf/config-devel.conf

And for your staging deployment you could do:

    $ heroku config:set CONFIGURATOR=conf/config-staging.conf

Where each conf file modifies files differently depending on the instance. (I
use this to manipulate the nginx configuration settings for different deploys).

Enjoy.
