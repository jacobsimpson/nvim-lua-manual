---
weight: 1
bookCollapseSection: true
title: "Neovim APIs"
---

# Neovim APIs

There are a variety of APIs available for scripting Neovim using Lua.

*  `vim.split` or `vim.gsplit`
*  `vim.trim`
*  [`vim.api.nvim_*`](https://neovim.io/doc/user/api.html)
*  Built in [functions](https://neovim.io/doc/user/eval.html#functions) are available as `vim.fn.*`
*  See `:help lua-stdlib` for more details.
*  Lua APIs

## String Functions

*  `join`
*  `stridx`
*  `string.*` from Lua
*  `strlen`
*  `strpart`
*  `strridx`
*  `submatch`
*  `substitute`
*  `vim.split` or `vim.gsplit`
*  `vim.stricmp`
*  `vim.trim`

## Directory Functions

*  `delete`
*  `filereadable`
*  `filewritable`
*  `finddir`
*  `findfile`
*  `fnameescape`
*  `fnamemodify`
*  `getcwd`
*  `getfperm`
*  `getfsize`
*  `getftime`
*  `getftype`
*  `isdirectory`
*  `mkdir`
*  `nvim_set_current_dir`
*  `readdir`
*  `readfile`
*  `rename`
*  `resolve`
*  `simplify`

## Evaluation/Execution Functions

*  `luaeval`
*  `system`
*  `systemlist`
*  `vim.api.nvim_call_function`
*  `vim.api.nvim_command`
