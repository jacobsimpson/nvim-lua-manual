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

{{< highlight lua >}}
local servername = vim.api.nvim_eval("v:servername")
{{< / highlight >}}

### Calling VimL Functions

{{< highlight lua >}}
nvim_call_function(...)
{{< / highlight >}}

## From VimScript

### Calling Lua Code from VimL

{{< highlight lua >}}
nvim_execute_lua(...)
{{< / highlight >}}


