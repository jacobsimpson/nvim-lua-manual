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

```lua
local servername = vim.api.nvim_eval("v:servername")
```

### Calling VimL Functions

```lua
nvim_call_function(...)
```

## From VimScript

### Calling Lua Code from VimL

```lua
nvim_execute_lua(...)
```


