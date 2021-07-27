local cmd = vim.cmd

local colors = require("onedark.colors")

local function hi_guifg(group, color)
  cmd("hi " .. group .. " guifg=" .. color)
end

local function hi_guibg(group, color)
  cmd("hi " .. group .. " guibg=" .. color)
end

-- local function hi_gui(group, gui, fg_color, bg_color)
--   cmd("hi " .. group .. " gui=" .. gui .. " guifg=" .. fg_color .. " guibg=" .. bg_color)
-- end

local function hi_guifg_bg(group, fg_color, bg_color)
  cmd("hi " .. group .. " guifg=" .. fg_color .. " guibg=" .. bg_color)
end

local function hi_gui(group, gui)
  cmd("hi " .. group .. " gui=" .. gui)
end

-- Reverse search block
hi_gui("Search", "reverse")
hi_guifg_bg("Search", "NONE", "NONE")

-- Folded Line
hi_guibg("Folded", colors.diff_change)

-- CursorLine: bold and green fg
hi_gui("CursorLineNr", "bold")
hi_guifg("CursorLineNr", "#87bf00")

-- Visual Block
-- hi_gui("Visual", "bold")
