---
bookCollapseSection: true
weight: 20
title: "Interacting with the User"
---

# Interacting with the User

## Echo

To put a message at the bottom of the screen, and in the `:messages` buffer:

{{< highlight lua >}}
print("Something really important.")
{{< / highlight >}}

This is analogous to the `echo` command in VimScript.

## Displaying something

there is a `confirm` API method in Vim documentation that asks questions and returns the selected response.

### A Split

### A Floating Window

#### A Floating Window with Borders

#### For a tool tip

This uses Neovim's new [floating
window](https://neovim.io/doc/user/api.html#api-floatwin) capability to overlay
a window. The window is backed by a buffer containing the two lines, "test" and
"text".

{{< highlight lua >}}
local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_lines(buf, 0, -1, true, {"test", "text"})
local opts = {
    relative = 'cursor',
	width = 10,
	height = 2,
	col = 0,
	row = 1,
	anchor = 'NW',
	style = 'minimal'
}
local win = vim.api.nvim_open_win(buf, 0, opts)
-- optional: change highlight, otherwise Pmenu is used
vim.api.nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
{{< / highlight >}}

