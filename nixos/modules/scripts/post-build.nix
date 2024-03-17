{
  sync-pass = ''
    if [ -n $(command -v pass) ]; then
      if [ ! -d "$HOME/.password-store" ]; then
        pushd $HOME &> /dev/null;

        git clone git@github.com:psanker/passwords.git .password-store

        popd &> /dev/null;
      else
        pass git pull -q
      fi
    fi
  '';
}
