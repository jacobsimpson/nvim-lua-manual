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

{{< highlight lua >}}
vim.api.nvim_buf_set_option(statusBuffer, 'buftype', 'nofile')
vim.api.nvim_buf_set_option(statusBuffer, 'filetype', 'lua')
{{< / highlight >}}

I would think that it would be possible to set the `modifiable` attribute in
the same way as the attributes above, using `nvim_buf_set_option`, but I've not
been able to figure out the syntax for that. So, I do it this way:

{{< highlight lua >}}
vim.api.nvim_command("setlocal nomodifiable")
{{< / highlight >}}

The name of a buffer is not a standard option, and has it's own function:

{{< highlight lua >}}
vim.api.nvim_buf_set_name(statusBuffer, 'hg status')
{{< / highlight >}}

