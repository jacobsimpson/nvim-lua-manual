---
title: Introduction
type: docs
---

# Building Neovim Plugins in Lua

## First

To acknowledge, all this information is available somewhere, most of it in the
Neovim `:help` documentation. I just find it easier to pull it all together.
I'm not a proficient plugin writer, and when I do write a plugin, I'm just
trying to quickly solve a problem and get back to work. I want a place to see
examples and copy working code.

I don't really enjoy working in VimScript, so this is as much about Lua as
possible. However, at heart, I am a pragmatist, so where it makes sense, I put
things in VimScript. `autocmd`, key mappings, commands and the like. I don't
cover how to do any of that stuff in much depth here, there are much better
resources available.

# A Basic Running Plugin

Clone and own a [working
example](https://github.com/jacobsimpson/nvim-example-lua-plugin).

TODO: There have been a lot of Neovim improvements, this example could probably
use some  updates. Also, if the `luamodule` was named `myluamodule` it would be
just a little more obvious that the directory name/module name can be changed.

TODO: Make a bash script that downloads and renames everything, so that you can
run one of those fancy curl commands and have a working plugin in a moment.

## Communicating Between VimL and Lua

### Accessing VimL Variables

```lua
local servername = vim.api.nvim_eval("v:servername")
```

# Job Control

```lua
vim.fn.jobstart("ls")
```

### Calling Lua Code from VimL

```lua
nvim_execute_lua(...)
```

### Calling VimL Code from Lua

```lua
nvim_call_function(...)
```

## User Interface Bits

### Displaying something

there is a `confirm` API method in Vim documentation that asks questions and returns the selected response.

#### Echo

#### A Split

#### A Floating Window

##### A Floating Window with Borders

##### For a tool tip

```lua
let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])
    let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
        \ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}
    let win = nvim_open_win(buf, 0, opts)
    " optional: change highlight, otherwise Pmenu is used
    call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
```

## Interacting With Neovim

### Reading a Buffer

### Modifying a Buffer

### Clearing a Buffer

### Replacing a Buffer

### Setting Options on a Buffer

```lua
vim.api.nvim_buf_set_option(statusBuffer, 'buftype', 'nofile')
vim.api.nvim_buf_set_option(statusBuffer, 'filetype', 'lua')
```

I would think that it would be possible to set the `modifiable` attribute in
the same way as the attributes above, using `nvim_buf_set_option`, but I've not
been able to figure out the syntax for that. So, I do it this way:

```lua
vim.api.nvim_command("setlocal nomodifiable")
```

The name of a buffer is not a standard option, and has it's own function:

```lua
vim.api.nvim_buf_set_name(statusBuffer, 'hg status')
```

### Networking, Communication and Job Control

#### How to use Neovim to send a message to a Running Neovim instance

```sh
nvim --noplugin --cmd "lua vim.fn.rpcrequest(vim.fn.sockconnect('pipe', '/var/folders/nh/lwpxl66111j103y85rw0kdvw0000gn/T/nvimNdff2D/0', { rpc = true }), 'nvim_command', ':e ~/.zshrc')" --cmd "q" --headless
```

