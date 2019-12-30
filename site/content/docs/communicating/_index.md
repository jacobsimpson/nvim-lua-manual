---
weight: 10
bookCollapseSection: true
title: "VimL to Lua and back"
---

# VimL to Lua and back

There are different reasons for having VimScript and Lua code interact, such as
calling existing functions, setting variables to configure other plugins, or
Neovim. Below are descriptions of techniques for different kinds of
interactions between VimScript and Lua.

## From Lua

### Accessing VimL Variables

There are a number of
[variables](https://neovim.io/doc/user/eval.html#internal-variables) with
different scopes. Depending on the scope of the variable, there are different
APIs for accessing the values.

1.  Global variables (`echo g:something`):

    {{< highlight lua >}}
local a = vim.api.nvim_get_var('something')
vim.api.nvim_set_var('something', 'value')
{{< / highlight >}}

2.  Vim variables (`echo v:servername`):

    {{< highlight lua >}}
print(vim.api.nvim_get_vvar("servername"))
{{< / highlight >}}

3.  And for general expression evaluation, which can include accessing variables:

    {{< highlight lua >}}
local servername = vim.api.nvim_eval("v:servername")
{{< / highlight >}}

### Calling VimL Functions

{{< highlight lua >}}
vim.api.nvim_call_function(...)
{{< / highlight >}}

## From VimScript

### Calling Lua Code from VimL

{{< highlight vim >}}
nvim_execute_lua(...)
{{< / highlight >}}

Starting in  Neovim 0.5.0, it is possible to invoke global Lua
functions directly from VimL:

{{< highlight vim >}}
v:lua.luafunc(arg1, arg2)
{{< / highlight >}}

