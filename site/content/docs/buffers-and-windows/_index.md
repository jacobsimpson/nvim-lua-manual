---
bookCollapseSection: true
weight: 20
title: "Buffers and Windows"
---

# Buffers and Windows

### Reading a Buffer

### Modifying a Buffer

### Clearing a Buffer

### Replacing a Buffer

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
vim.api.nvim_buf_set_name(statusBuffer, 'my special buffer')
{{< / highlight >}}

