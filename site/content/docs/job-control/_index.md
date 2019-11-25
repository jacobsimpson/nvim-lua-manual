---
bookCollapseSection: true
weight: 20
title: "Job Control"
---

# Job Control

I'm using this term to refer to starting, communicating with and otherwise
controlling external processes. There are a few options available, with
different trade offs.

## Vim `system` or `systemlist`

It is possible to use the Vim
[`system`](https://neovim.io/doc/user/eval.html#system())  or
[`systemlist`](https://neovim.io/doc/user/eval.html#systemlist()) API.

{{< highlight lua >}}
local result = vim.fn.system("ls")
if vim.api.nvim_get_vvar("shell_error") != 0 then
    -- Error handling.
else
    -- Success handling.
end
{{< / highlight >}}

## Vim `jobstart`

The Neovim job control API is available in Lua like so:

{{< highlight lua >}}
vim.fn.jobstart("ls")
{{< / highlight >}}

However, at the moment, it is unable to accept the second parameter that allows
callbacks to be configured. There is an open issue,
[neovim/7607](https://github.com/neovim/neovim/issues/7607).

## Lua `popen`

{{< highlight lua >}}
local handle = io.popen("ls")
local result = handle:read("*a")
handle:close()
{{< / highlight >}}

The drawbacks are:

1.  It isn't straightforward to capture the result code of the process
    execution. [Stackoverflow
    Discussion](https://stackoverflow.com/questions/7607384/getting-return-status-and-program-output/14031974)

2.  It isn't straightforward to capture the stdout and stderr.

## Networking, Communication and Job Control

## How to use Neovim to send a message to a Running Neovim instance

{{< highlight bash >}}
nvim --noplugin --cmd "lua vim.fn.rpcrequest(vim.fn.sockconnect('pipe', '/var/folders/nh/lwpxl66111j103y85rw0kdvw0000gn/T/nvimNdff2D/0', { rpc = true }), 'nvim_command', ':e ~/.zshrc')" --cmd "q" --headless
{{< / highlight >}}

