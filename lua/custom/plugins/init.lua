-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'github/copilot.vim',
    config = function()
      vim.cmd [[
        let g:node_host_prog = '~/.nvm/versions/node/v20.10.0/lib/node_modules'
        let g:copilot_node_command = '~/.nvm/versions/node/v20.10.0/bin/node'
      ]]
    end,
  },
  {
    'vim-test/vim-test',
    config = function()
      vim.cmd [[
        function! BufferTermStrategy(cmd)
          exec 'te ' . a:cmd
        endfunction

        let g:test#custom_strategies = {'bufferterm': function('BufferTermStrategy')}
        let g:test#strategy = 'bufferterm'
      ]]
    end,
    keys = {
      { '<leader>Tf', '<cmd>TestFile<cr>', silent = true, desc = 'Run this file' },
      { '<leader>Tn', '<cmd>TestNearest<cr>', silent = true, desc = 'Run nearest test' },
      { '<leader>Tl', '<cmd>TestLast<cr>', silent = true, desc = 'Run last test' },
    },
  },
  {
    'mfussenegger/nvim-lint',
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        elixir = { 'credo' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'elixir-tools/elixir-tools.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local elixir = require 'elixir'
      local elixirls = require 'elixir.elixirls'

      elixir.setup {
        nextls = { enable = false },
        credo = {},
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = true,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            require('which-key').register {
              ['<leader>x'] = { name = 'Eli[x]ir', _ = 'which_key_ignore' },
            }
            vim.keymap.set('n', '<space>xP', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set('n', '<space>xp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set('n', '<space>xr', ':ElixirRestart<cr>', { buffer = true, noremap = true })
            vim.keymap.set('n', '<space>xo', ':ElixirOutputPanel<cr>', { buffer = true, noremap = true })
            vim.keymap.set('v', '<space>xm', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
          end,
        },
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    'olimorris/persisted.nvim',
    lazy = false,
    config = true,
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {}, -- your configuration
  },
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      on_attach = function(client, bufnr)
        vim.keymap.set('n', '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', { desc = '[o]rganize Imports' })
        vim.keymap.set('n', '<leader>ts', '<cmd>TSToolsSortImports<cr>', { desc = '[s]ort Imports' })
        vim.keymap.set('n', '<leader>tr', '<cmd>TSToolsRemoveUnused<cr>', { desc = '[r]emove Unused' })
        vim.keymap.set('n', '<leader>tR', '<cmd>TSToolsRenameFile<cr>', { desc = '[R]ename File' })
        vim.keymap.set('n', '<leader>tf', '<cmd>TSToolsFixAll<cr>', { desc = '[f]ix All' })
        vim.keymap.set('n', '<leader>tF', '<cmd>TSToolsFileReferences<cr>', { desc = 'Rename [F]ile' })
      end,
    },
    -- keys = {
    -- { '<leader>to', '<cmd>TSToolsOrganizeImports<cr>', desc = '[o]rganize Imports' },
    -- { '<leader>ts', '<cmd>TSToolsSortImports<cr>', desc = '[s]ort Imports' },
    -- { '<leader>tr', '<cmd>TSToolsRemoveUnused<cr>', desc = '[r]emove Unused' },
    -- { '<leader>tR', '<cmd>TSToolsRenameFile<cr>', desc = '[R]ename File' },
    -- { '<leader>tf', '<cmd>TSToolsFixAll<cr>', desc = '[f]ix All' },
    -- { '<leader>tF', '<cmd>TSToolsFileReferences<cr>', desc = 'Rename [F]ile' },
    -- },
  },
}
