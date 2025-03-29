return {

  --I can't even read all this stuff man :(
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      --We don't need this lualine require madness 🤷, for real tough bro we don't
      --Making custom theme
      local custom_theme = require("lualine.themes.16color")

      --Actual colors

      --Normal fg
      custom_theme.normal.a.fg = "#fffbfb"
      custom_theme.normal.b.fg = "#fffbfb"
      custom_theme.normal.c.fg = "#fffbfb"
      --Normal bg
      custom_theme.normal.a.bg = "#624e88"
      custom_theme.normal.b.bg = "#cb9df0"
      custom_theme.normal.c.bg = "#1b1926"
      --Insert fg
      custom_theme.insert.a.fg = "#fffbfb"
      --Insert bg
      custom_theme.insert.a.bg = "#e4b1f0"
      --Visual fg
      custom_theme.visual.a.fg = "#fffbfb"
      --Visual bg
      custom_theme.visual.a.bg = "#bb7feb"
      --Replace fg
      custom_theme.replace.a.fg = "#fffbfb"
      --Replace bg
      custom_theme.replace.a.bg = "#c48bf0"
      --Inactive fg
      custom_theme.inactive.a.fg = "#fffbfb"
      custom_theme.inactive.b.fg = "#fffbfb"
      custom_theme.inactive.c.fg = "#fffbfb"
      --Incative bg
      custom_theme.inactive.a.bg = "#cb9df0"
      custom_theme.inactive.b.bg = "#1b1926"
      custom_theme.inactive.c.bg = "#1b1926"

      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = custom_theme, --theme is here <==
          component_separators = { left = "/", right = "\\" }, -- Separators between components
          section_separators = { left = "", right = "" }, -- Separators between sections
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),

            {
              "copilot",
              -- Default values
              symbols = {
                status = {
                  icons = {
                    enabled = " ",
                    sleep = " ", -- auto-trigger disabled
                    disabled = " ",
                    warning = " ",
                    unknown = " ",
                  },
                  hl = {
                    enabled = "#c48bf0",
                    sleep = "#fffbfb",
                    disabled = "#6272A4",
                    warning = "#FFFBBE",
                    unknown = "#FF5555",
                  },
                },
                spinners = "dots", -- has some premade spinners
                spinner_color = "#6272A4",
              },
              show_colors = true,
              show_loading = true,
            },
            "encoding",
            "fileformat",
            "filetype",
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
}
