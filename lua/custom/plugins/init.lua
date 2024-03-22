-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'github/copilot.vim' },
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
            vim.keymap.set('n', '<space>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
            vim.keymap.set('v', '<space>em', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
          end,
        },
      }
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
}
