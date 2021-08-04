local present1, gl = pcall(require, "galaxyline")
local present2, condition = pcall(require, "galaxyline.condition")
if not (present1 or present2) then
    return
end

local gls = gl.section
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
-- local extension = require('galaxyline.provider_extensions')

gl.short_line_list = {'NvimTree','vista', 'vista_kind', 'dbui','packer'}

local onedark_c = require "onedark.colors"

local colors = {
  bg         = onedark_c.bg_d;
  fg         = onedark_c.fg;
  section_bg = onedark_c.bg3;

  diag_error = {fg = onedark_c.dark_red};
  diag_hint  = {fg = onedark_c.dark_purple};
  diag_info  = {fg = onedark_c.dark_cyan};
  diag_warn  = {fg = onedark_c.dark_yellow};

  grey       = onedark_c.grey;
  orange     = onedark_c.orange;
  yellow     = onedark_c.yellow;
  bg_yellow  = onedark_c.bg_yellow;
  green      = onedark_c.green;
  cyan       = onedark_c.cyan;
  blue       = onedark_c.blue;
  red        = onedark_c.red;
  teal       = onedark_c.dark_cyan;
  purple     = onedark_c.purple;
}

local mode_color_schema = {
  n = colors.green,
  i = colors.cyan,
  c = colors.yellow,
  V = colors.orange,
  [''] = colors.orange,
  v = colors.orange,
  s = colors.bg_yellow,
  S = colors.bg_yellow,
  r = colors.red,
  R = colors.red,
}

local mode_color = function()
  return mode_color_schema[vim.fn.mode()]
end

local icons = {
    sep = {
        right = "",
        left = ""
    },
    diagnostic = {
        error = "  ",
        warn = "  ",
        info = "  "
    },
    diff = {
        add = " ",
        modified = " ",
        remove = " "
    },
    git = "",
    file = {
      read_only = '',
      modified = '',
    }
}

-- Functions
local white_space = function() return ' ' end

local function get_search_results()
  local search_term = vim.fn.getreg('/')
  local search_count = vim.fn.searchcount({recompute = 1, maxcount = -1})
  local active = vim.v.hlsearch == 1 and search_count.total > 0

  if active then
    return "  " .. search_term .. ' [' .. search_count.current .. '/' .. search_count.total .. '] '
  end
end

local function file_name(is_active, highlight_group)
  local normal_fg = is_active and colors.fg or colors.grey
  local modified_fg = is_active and colors.red or colors.orange
  if vim.bo.modifiable then
    if vim.bo.modified then
      vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. modified_fg)
    else
      vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. normal_fg)
    end
  end
  return fileinfo.get_current_file_name(icons.file.modified, icons.file.read_only)
end

-- --------------------------------------Left side-----------------------------------------------------------
local i = 1
gls.left[i] = {
  FirstElement = {
    provider = function()
      vim.api.nvim_command('hi GalaxyFirstElement guifg='..mode_color())
      return icons.sep.right
    end,
  },
}

i = i + 1
gls.left[i] = {
  Logo = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLogo guibg='..mode_color())
      return "  "
    end,
    highlight = {colors.bg, colors.bg},
  },
}

i = i + 1
gls.left[i] = {
  ViMode = {
    provider = function()
      local alias = {
        n      = 'NORMAL ',
        i      = 'INSERT ',
        c      = 'COMMAND ',
        V      = 'VISUAL ',
        [''] = 'VISUAL LINE ',
        v      = 'VISUAL BLOCK ',
        s      = 'SELECT ',
        S      = 'SELECT ',
        r      = 'REPLACE ',
        R      = 'REPLACE ',
      }
      -- vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color()..' gui=bold')
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color()..' gui=bold')
      return '  ' .. alias[vim.fn.mode()]
    end,
    highlight = { colors.bg, colors.bg },
  },
}

i= i + 1
gls.left[i] = {
  ViModeSep = {
    provider = function()
      -- vim.api.nvim_command('hi GalaxyViModeSep guibg='..mode_color()..' guibg='..colors.section_bg)
      vim.api.nvim_command('hi GalaxyViModeSep guifg='..colors.bg..' guibg='..colors.section_bg)
      return icons.sep.left .. ' '
    end,
  },
}

i = i + 1
gls.left[i] ={
  FileIcon = {
    provider = {white_space, 'FileIcon'},
    condition = condition.buffer_not_empty,
    highlight = { fileinfo.get_file_icon_color, colors.section_bg },
  },
}

i = i + 1
gls.left[i] = {
  MyFileName = {
    provider = function()
      return file_name(true, 'GalaxyMyFileName')
    end,
    condition = condition.buffer_not_empty,
    highlight = { colors.fg, colors.section_bg },
    separator = icons.sep.left,
    separator_highlight = {colors.section_bg, colors.bg}
  }
}

-- disable, vista is slow
-- i = i + 1
-- gls.left[i] = {
--   Context = {
--     provider = extension.vista_nearest,
--     highlight = {colors.blue, colors.bg}
--   }
-- }

i = i + 1
gls.left[i] = {
  Context = {
    provider = get_search_results,
    highlight = {colors.blue, colors.bg},
    condition = function () return vim.fn.hlsearch end,
    -- separator = icons.sep.left,
    -- separator_highlight = {colors.grey, colors.bg }
  }
}

i = i + 1
gls.left[i] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = icons.diagnostic.error,
    highlight = {colors.diag_error.fg, colors.bg}
  }
}

i = i + 1
gls.left[i] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = icons.diagnostic.warn,
    highlight = {colors.diag_warn.fg, colors.bg},
  }
}

i = i + 1
gls.left[i] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = icons.diagnostic.info,
    highlight = {colors.diag_info.fg, colors.bg},
  }
}

-- ------------------------------------Right side-----------------------------------------------------
local j = 1
gls.right[j] = {
  ShowLspClient = {
    provider = function()
      local clients = vim.lsp.get_active_clients()
      if next(clients) ~= nil then
        local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name .. " "
          end
        end
        return ""
      else
        return ""
      end
    end,
    condition = function()
      local tbl = {["dashboard"] = true, [""] = true}
      if tbl[vim.bo.filetype] then
        return false
      end
      return true
    end,
    icon = "  ",
    highlight = {colors.purple, colors.section_bg},
    separator = icons.sep.right,
    separator_highlight = {colors.section_bg, colors.bg}
  }
}

j = j + 1
gls.right[j] = {
  GitIcon = {
    provider = function() return " " end,
    condition = condition.check_git_workspace,
    highlight = {colors.bg, colors.orange},
    separator = icons.sep.right,
    separator_highlight = {colors.orange, colors.section_bg}
  }
}

j = j + 1
gls.right[j] = {
  GitBranch = {
    -- provider = function () return vcs.get_git_branch() .. " " end,
    provider = vcs.get_git_branch,
    condition = condition.check_git_workspace,
    highlight = {colors.bg, colors.orange},
  }
}

j = j + 1
gls.right[j] = {
  DiffSep = {
    provider = function () return icons.sep.left .. " " end,
    condition = condition.hide_in_width,
    highlight = {colors.orange, colors.section_bg}
  }
}

j = j + 1
gls.right[j] = {
  DiffAdd = {
    provider = vcs.diff_add,
    condition = condition.hide_in_width,
    icon = icons.diff.add,
    highlight = {colors.green, colors.section_bg}
  }
}

j = j + 1
gls.right[j] = {
  DiffModified = {
    provider = vcs.diff_modified,
    condition = condition.hide_in_width,
    icon = icons.diff.modified,
    highlight = {colors.yellow, colors.section_bg}
  }
}

j = j + 1
gls.right[j] = {
  DiffRemove = {
    provider = vcs.diff_remove,
    condition = condition.hide_in_width,
    icon = icons.diff.remove,
    highlight = {colors.red, colors.section_bg}
  }
}

j = j + 1
gls.right[j] = {
  LineInfoSeparator = {
    provider = function ()
	    return " "
    end,
    highlight = {colors.bg, colors.green},
    separator = icons.sep.right,
    separator_highlight = {colors.green, colors.section_bg},
  }
}

j = j + 1
gls.right[j] = {
  LineInfo = {
    provider = function()
      local sep = "龍"
      local current_line = vim.fn.line(".")
      local current_col = vim.fn.col(".")
      local total_line = vim.fn.line("$")

      local LineColumn = sep .. string.format("%3d:%2d ", current_line, current_col)

      if current_line == 1 then
          return "  Top " .. LineColumn
      elseif current_line == vim.fn.line("$") then
          return "  Bot " .. LineColumn
      end
      local result, _ = math.modf((current_line / total_line) * 100)
      return "  " .. result .. "% " .. LineColumn
    end,
    highlight = { colors.fg, colors.section_bg },
  },
}

j = j + 1
gls.right[j] = {
  LastElement = {
    provider = function()
      vim.api.nvim_command('hi GalaxyLastElement guifg='..mode_color())
      return icons.sep.left
    end,
  },
}

-- -------------------------Short status line---------------------------------------
local k = 1
gls.short_line_left[k] = {
  SFirstElement = {
    provider = function() return icons.sep.right end,
    highlight = { colors.grey, 'NONE' },
    separator = icons.sep.left,
    separator_highlight = {colors.bg, colors.bg},
  },
}

k = k + 1
gls.short_line_left[k] ={
  SFileIcon = {
    provider = 'FileIcon',
    highlight = { colors.grey, colors.bg },
  },
}

k = k + 1
gls.short_line_left[k] = {
  SMyFileName = {
    provider = function() return file_name(false, 'GalaxySMyFileName') end,
    highlight = {colors.grey, colors.bg},
    separator = icons.sep.left,
    separator_highlight = {colors.bg, colors.bg}
  }
}

k = k + 1
gls.short_line_right[k] = {
  SLastElement = {
    provider = function() return icons.sep.left end,
    highlight = { colors.grey, 'NONE' }
  },
}
