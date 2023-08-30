return {
  { "tpope/vim-surround" },
  { "f-person/git-blame.nvim" },
  { "airblade/vim-gitgutter" },
  { "tree-sitter/tree-sitter-go" },
  { "windwp/nvim-spectre" },
  { "danilamihailov/beacon.nvim" },
  { "bazelbuild/vim-ft-bzl" },
  { "google/vim-maktaba" },
  { "bazelbuild/vim-bazel" },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      local hop = require("hop")
      hop.setup({
        create_hl_autocmd = true,
        uppercase_labels = false,
        multi_windows = false,
      })
    end,
  },
}
