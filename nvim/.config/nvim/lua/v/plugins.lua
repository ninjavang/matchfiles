local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim"                      -- Have packer manage itself
  use "nvim-lua/popup.nvim"                         -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim"                       -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs"                       -- Autopairing brackets etc
  use "numToStr/Comment.nvim"                       -- Commenting helper
  use "kyazdani42/nvim-web-devicons"                -- Some cool icons used by multiple plugins
  use "kyazdani42/nvim-tree.lua"                    -- Explorer
  use "akinsho/bufferline.nvim"                     -- Gives the buffers a tabish interface
  use "moll/vim-bbye"                               -- Not sure what this does, used by other plugin
  use "akinsho/toggleterm.nvim"                     -- Toggles a terminal
  use "preservim/tagbar"                            -- Gives a bar sumerizing the document
  use "folke/which-key.nvim"                        -- Display shortcuts when pressing leader
  -- Colorschemes
  use "lunarvim/colorschemes"

  -- Completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "saadparwaiz1/cmp_luasnip"

  -- Snippers
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets"
  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use "p00f/nvim-ts-rainbow"
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
