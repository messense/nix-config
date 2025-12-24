{
  lib,
  username,
  useremail,
  ...
}:
{
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      user.name = username;
      user.email = useremail;
      core.excludesFile = "~/.gitignore_global";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    signing = {
      key = "1961A03283467E2B2FA2BD15BB41A8A2C716CCA9";
      signByDefault = true;
    };
  };

  programs.delta = {
    enable = true;
    options = {
      features = "side-by-side";
    };
  };
}
