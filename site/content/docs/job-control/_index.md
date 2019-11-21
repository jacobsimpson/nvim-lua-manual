---
bookCollapseSection: true
weight: 20
---

# Job Control

{{< highlight lua >}}
vim.fn.jobstart("ls")
{{< / highlight >}}

## Networking, Communication and Job Control

## How to use Neovim to send a message to a Running Neovim instance

{{< highlight bash >}}
nvim --noplugin --cmd "lua vim.fn.rpcrequest(vim.fn.sockconnect('pipe', '/var/folders/nh/lwpxl66111j103y85rw0kdvw0000gn/T/nvimNdff2D/0', { rpc = true }), 'nvim_command', ':e ~/.zshrc')" --cmd "q" --headless
{{< / highlight >}}

