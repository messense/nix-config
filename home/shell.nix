{ ... }:
{
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
    initExtra = ''
      export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"

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
