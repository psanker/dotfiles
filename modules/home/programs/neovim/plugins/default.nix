{pkgs}: {
  plugins =
    import ./git.nix
    // import ./lsp.nix
    // import ./noice.nix
    // import ./telescope.nix
    // import ./treesitter.nix
    // {
      commentary.enable = true;
      fidget.enable = true;
      floaterm.enable = true;
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
      trouble.enable = true;
      undotree.enable = true;
      which-key.enable = true;
      zk = {
        enable = true;
        picker = "telescope";
      };
    };
  extraPlugins = with pkgs.vimPlugins; [
    luasnip
    vim-pencil
    zen-mode-nvim

    # I need the actual lua code for the statusline and theme
    (pkgs.vimUtils.buildVimPlugin rec {
      pname = "rose-pine";
      version = "14b371fb783a8cfdade04544fb782f0bb6f7c904";
      src = pkgs.fetchFromGitHub {
        owner = "rose-pine";
        repo = "neovim";
        rev = version;
        sha256 = "sha256-MA1le+hIMpm7uqx4UsJLE+iuySX4VDgDjqxfRBgZa2Y=";
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
