---
bookCollapseSection: true
weight: 20
---

# Buffers and Windows

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

