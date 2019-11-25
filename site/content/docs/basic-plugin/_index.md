---
weight: 1
bookCollapseSection: true
title: "A Basic Lua Plugin"
---

# A Basic Lua Plugin

## Quick Start

There are a few different files involved in setting up a plugin, and a specific
directory structure. I like to start from a working plugin and start adding my
code.

{{< highlight bash >}}
bash \
  <(curl -o- https://raw.githubusercontent.com/jacobsimpson/nvim-example-lua-plugin/master/install.sh) \
  mynewplugin
{{< / highlight >}}

Once that is done, you have a new plugin ready to go. It doesn't do anything
except print some messages, but it is enough to get you started.

To use the new plugin, add it to your `runtimepath` when starting Neovim.

{{< highlight bash >}}
nvim --cmd "set rtp+=./mynewplugin"
{{< / highlight >}}

## More Detail

The `vim` file in the `plugin` directory will be executed when vim starts. The
`lua require(...)` statements in the `vim` files will load Lua files.

In order to satisfy the `require` call, the Lua interpreter that is part of
Neovim will look in the `lua` subdirectory of the directories on the
`runtimepath` for the arguments specified in the call to `require`. In the
example above, where `./mynewplugin` was added to the `runtimepath`,
`require("mynewplugin")` would cause the Lua interpreter to look in
`./mynewplugin/lua` for a `mynewplugin` directory.

If `require` points to a directory, the interpreter will load the
`init.lua` file in that directory. If the `require` points to a file, the
interpreter will append a `.lua` extension, and load the file.

TODO: There have been a lot of Neovim improvements, this example could probably
use some  updates. Also, if the `luamodule` was named `myluamodule` it would be
just a little more obvious that the directory name/module name can be changed.

