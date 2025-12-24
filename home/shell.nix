{ pkgs, _1password-shell-plugins, ... }:
{
  imports = [ _1password-shell-plugins.hmModules.default ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-completions"
        "getantidote/use-omz"
        "ohmyzsh/ohmyzsh path:lib"
      ];
    };
    initContent = ''
      export CARGO_HOME="$HOME/.cargo"
      export RUSTUP_HOME="$HOME/.rustup"

      export PATH="$HOME/.local/bin:$CARGO_HOME/bin:/opt/homebrew/bin:$PATH"

      # For Git GPG signing
      export GPG_TTY=$(tty)

      # Windsurf
      export PATH="$HOME/.codeium/windsurf/bin:$PATH"

      # LM Studio CLI (lms)
      export PATH="$PATH:$HOME/.cache/lm-studio/bin"
    '';
    envExtra = ''
      export HOMEBREW_BAT=1
      export BAT_THEME="Sublime Snazzy"
    '';
  };

  programs._1password-shell-plugins = {
    enable = true;
    # the specified packages as well as 1Password CLI will be
    # automatically installed and configured to use shell plugins
    plugins = with pkgs; [ gh ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
