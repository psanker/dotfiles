{pkgs}: {
  plugins =
    import ./lsp.nix
    // import ./noice.nix
    // import ./telescope.nix
    // {
      commentary.enable = true;
      fidget.enable = true;
      fugitive.enable = true;
      lualine.enable = true;
      navic.enable = true;
      oil.enable = true;
      surround.enable = true;
      todo-comments = {
        enable = true;
        search = {
          # Default is ripgrep, so just need to provide the args
          args = [
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--glob=!{_site,renv}"
          ];
        };
        highlight.commentsOnly = false;
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        indent = true;
        nixGrammars = true;
        ensureInstalled = "all";
        incrementalSelection.enable = true;
      };
      which-key.enable = true;
      zk = {
        enable = true;
        picker = "telescope";
      };
    };
  extraPlugins = with pkgs.vimPlugins; [
    luasnip

    ## User interface
    #  Since my statusline is interconnected with
    #  zen-mode, I need to pull these and configure manually
    (pkgs.vimUtils.buildVimPlugin rec {
      # I need the actual lua code for the statusline and theme
      pname = "rose-pine";
      version = "14b371fb783a8cfdade04544fb782f0bb6f7c904";
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "neovim";
        rev = version;
        sha256 = "sha256-MA1le+hIMpm7uqx4UsJLE+iuySX4VDgDjqxfRBgZa2Y=";
      };
    })

    (pkgs.vimUtils.buildVimPlugin rec {
      pname = "zen-mode";
      version = "78557d972b4bfbb7488e17b5703d25164ae64e6a";
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "zen-mode.nvim";
        rev = version;
        sha256 = "sha256-G5/AskXEA0vl9GGUR8NG8PmL/HFcItZJWB+LyKd3R2k=";
      };
    })

    # Harpoon 2 is on a separate branch
    (pkgs.vimUtils.buildVimPlugin rec {
      pname = "harpoon";
      version = "a38be6e0dd4c6db66997deab71fc4453ace97f9c";
      src = pkgs.fetchFromGitHub {
        owner = "ThePrimeagen";
        repo = "harpoon";
        rev = version;
        sha256 = "sha256-RjwNUuKQpLkRBX3F9o25Vqvpu3Ah1TCFQ5Dk4jXhsbI=";
      };
    })

    # Nvim-R is not anywhere because it's *fancy*
    (pkgs.vimUtils.buildVimPlugin rec {
      pname = "Nvim-R";
      version = "167ccf60f57616708bc6c556bc3f915bf91591a8";
      src = pkgs.fetchFromGitHub {
        owner = "jalvesaq";
        repo = "Nvim-R";
        rev = version;
        sha256 = "0msn7zz0hr5gj72i04vdl1kdrfz3bcms7fzv05l3gvndby1iagb0";
      };
      buildInputs = [pkgs.which pkgs.zip];
    })
  ];
}
