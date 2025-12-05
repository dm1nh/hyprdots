return {
  {
    "nvim-mini/mini.icons",
    version = "*",
    opts = {},
  },
  {
    "nvim-mini/mini.files",
    version = "*",
    keys = {
      { "<leader>e", "<cmd>lua MiniFiles.open()<cr>", desc = "Tree" },
    },
    config = function()
      local MiniFiles = require("mini.files")

      -- Transparent window
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win_id = args.data.win_id

          -- Customize window-local settings
          vim.wo[win_id].winblend = 10
          local config = vim.api.nvim_win_get_config(win_id)
          config.border, config.title_pos = "double", "right"
          vim.api.nvim_win_set_config(win_id, config)
        end,
      })

      -- Toggle dotfiles
      local show_dotfiles = false

      local filter_show = function(fs_entry)
        return true
      end

      local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end

      local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        MiniFiles.refresh({ content = { filter = new_filter } })
      end

      -- split windows
      local map_split = function(buf_id, lhs, direction)
        local rhs = function()
          -- Make new window and set it as target
          local cur_target = MiniFiles.get_explorer_state().target_window
          local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. " split")
            return vim.api.nvim_get_current_win()
          end)

          MiniFiles.set_target_window(new_target)

          -- This intentionally doesn't act on file under cursor in favor of
          -- explicit "go in" action (`l` / `L`). To immediately open file,
          -- add appropriate `MiniFiles.go_in()` call instead of this comment.
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = "Split " .. direction
        vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
      end

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate",
        callback = function(args)
          local buf_id = args.data.buf_id
          -- Tweak left-hand side of mapping to your liking
          vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
          -- Tweak keys to your liking
          map_split(buf_id, "<C-s>", "belowright horizontal")
          map_split(buf_id, "<C-v>", "belowright vertical")
          map_split(buf_id, "<C-t>", "tab")
        end,
      })

      MiniFiles.setup()
    end,
  },
}
