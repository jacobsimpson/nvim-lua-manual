---
bookCollapseSection: true
weight: 20
title: "Job Control"
---

# Job Control

The Neovim job control API is available in Lua like so:

{{< highlight lua >}}
vim.fn.jobstart("ls")
{{< / highlight >}}

However, at the moment, it is unable to accept the second parameter that allows
callbacks to be configured. There is an open issue,
[neovim/7607](https://github.com/neovim/neovim/issues/7607).

## Networking, Communication and Job Control

## How to use Neovim to send a message to a Running Neovim instance

{{< highlight bash >}}
nvim --noplugin --cmd "lua vim.fn.rpcrequest(vim.fn.sockconnect('pipe', '/var/folders/nh/lwpxl66111j103y85rw0kdvw0000gn/T/nvimNdff2D/0', { rpc = true }), 'nvim_command', ':e ~/.zshrc')" --cmd "q" --headless
{{< / highlight >}}

