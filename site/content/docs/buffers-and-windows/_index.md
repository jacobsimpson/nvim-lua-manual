---
bookCollapseSection: true
weight: 20
title: "Buffers and Windows"
---

# Buffers and Windows

## Setting Options

When you set an option in Neovim, the syntax you may be accustom to, as a user,
is `:set nomodifiable`, or `:set buftype=nofile`.

When using the the Neovim API to set options, I've found a couple things to
keep in mind.

1.  The option may be a buffer, window or global option, and there is a
    different API call for each. If you choose the wrong API, the API call will
    result in an error. So if you are trying to set an option, and you are
    getting an error indicating there is no such option, try a different API.

    {{< highlight lua >}}
vim.api.nvim_buf_set_option(buf, 'modifiable', false)
vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:Normal')
vim.api.nvim_set_option('wrapscan', false)
{{< / highlight >}}

2.  The option values are type sensitive. Options prefixed with `no` are
    boolean values, i.e. `:set nomodifiable` translates to `modifiable` with a
    boolean value.

    {{< highlight lua >}}
vim.api.nvim_buf_set_option(0, 'modifiable', true)
{{< / highlight >}}

### Reading a Buffer

### Modifying a Buffer

### Clearing a Buffer

{{< highlight lua >}}
vim.api.nvim_buf_set_lines(buf, 0, -1, true, {})
{{< / highlight >}}

### Replacing a Buffer

{{< highlight lua >}}
vim.api.nvim_buf_set_lines(buf, 0, -1, true, {"abc", "def"})
{{< / highlight >}}

### Appending to a Buffer

{{< highlight lua >}}
vim.api.nvim_buf_set_lines(buf, -1, -1, true, {"abc", "def"})
{{< / highlight >}}

### Setting Options on a Buffer

To set options on the current buffer, use 0 as the first argument. To specify a
buffer, use the value returned by `nvim.api.nvim_create_buf()` or
`nvim.api.nvim_list_bufs()`.

{{< highlight lua >}}
vim.api.nvim_buf_set_option(0, 'buftype', 'nofile')
vim.api.nvim_buf_set_option(0, 'filetype', 'lua')
vim.api.nvim_buf_set_option(0, 'modifiable', true)
{{< / highlight >}}

The name of a buffer is not a standard option, and has it's own function:

{{< highlight lua >}}
vim.api.nvim_buf_set_name(buf, 'my special buffer')
{{< / highlight >}}

