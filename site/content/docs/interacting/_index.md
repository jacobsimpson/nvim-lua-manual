---
bookCollapseSection: true
weight: 20
title: "Interacting with the User"
---

# Interacting with the User

## Echo

To put a message at the bottom of the screen, and in the `:messages` buffer:

```lua
print("Something really important.")
```

## Displaying something

there is a `confirm` API method in Vim documentation that asks questions and returns the selected response.

### A Split

### A Floating Window

#### A Floating Window with Borders

#### For a tool tip

```lua
let buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(buf, 0, -1, v:true, ["test", "text"])
    let opts = {'relative': 'cursor', 'width': 10, 'height': 2, 'col': 0,
        \ 'row': 1, 'anchor': 'NW', 'style': 'minimal'}
    let win = nvim_open_win(buf, 0, opts)
    " optional: change highlight, otherwise Pmenu is used
    call nvim_win_set_option(win, 'winhl', 'Normal:MyHighlight')
```

