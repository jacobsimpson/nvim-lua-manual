---
bookCollapseSection: true
weight: 20
title: "Interacting with the User"
---

# Error Handling

This is not a tutorial on Lua error handling mechanisms, it is a discussion of
Neovim error handling conventions.

The [preference](https://github.com/neovim/neovim/issues/11311) is:

1.    Raise an error (with `error` or `assert`) for syntax problems.
2.    Return an error message as the last return value if this is something the
      caller may like to recover from.

Also, when I ran a test program, it seems that pcall(...) doesn't fully catch
errors. They still end up being displayed.

{{< highlight lua >}}
function a()
    print("one")
    error("this is something")
    return 3
end

local result, err = pcall(a())
{{< / highlight >}}

-  Spend some more time testing this.
-  Try the `xpcall` method as well.
-  Test this out in a standard lua interpreter, to see if my understanding of
-  pcall matches reality.

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

At the moment this is no native support margins or borders on floating windows,
so there is a work around to nest floating windows. It is outlined in VimScript
[here](https://github.com/neovim/neovim/issues/9718#issuecomment-487334384) and
converted into Lua
[here](https://gabrielpoca.com/2019-11-13-a-bit-more-lua-in-your-vim/).

{{< highlight lua >}}
function NavigationFloatingWin()
  -- get the editor's max width and height
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- create a new, scratch buffer, for fzf
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  -- if the editor is big enough
  if (width > 150 or height > 35) then
    -- fzf's window height is 3/4 of the max height, but not more than 30
    local win_height = math.min(math.ceil(height * 3 / 4), 30)
    local win_width

    -- if the width is small
    if (width < 150) then
      -- just subtract 8 from the editor's width
      win_width = math.ceil(width - 8)
    else
      -- use 90% of the editor's width
      win_width = math.ceil(width * 0.9)
    end

    -- settings for the fzf window
    local opts = {
      relative = "editor",
      width = win_width,
      height = win_height,
      row = math.ceil((height - win_height) / 2),
      col = math.ceil((width - win_width) / 2)
    }

    -- create a new floating window, centered in the editor
    local win = vim.api.nvim_open_win(buf, true, opts)
  end
end
{{< / highlight >}}

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

