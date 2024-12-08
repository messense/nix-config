{
  description = "My system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {
        services.nix-daemon.enable = true;
        # Necessary for using flakes on macOS
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users.messense = {
          name = "messense";
          home = "/Users/messense";
        };

        # security.pam.enableSudoTouchIdAuth = true;

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        environment.systemPackages = [
          pkgs.bat
          pkgs.btop
          pkgs.cmake
          pkgs.direnv
          pkgs.gti
          pkgs.helix
          pkgs.htop
          pkgs.hyperfine
          pkgs.jq
          pkgs.mkalias
          pkgs.nil  # Language server for Nix
          pkgs.patchelf
          pkgs.ripgrep
          pkgs.rustup
          pkgs.starship
          pkgs.tokei
          pkgs.tree
          pkgs.vim
          pkgs.wget
          pkgs.zellij
          pkgs.zoxide
          pkgs.zstd
        ];

        system.activationScripts.applications.text = let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = "/Applications";
          };
        in
          pkgs.lib.mkForce ''
          # Set up applications.
          echo "Setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "Copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
              '';

        fonts.packages = with pkgs; [
          nerd-fonts.hack
        ];

        homebrew = {
          enable = true;
          # onActivation.cleanup = "uninstall";

          taps = [ "messense/macos-cross-toolchains" ];
          brews = [
            "aarch64-unknown-linux-gnu"
            "antidote"
            "bindgen"
            "cargo-zigbuild"
            "cbindgen"
            "cffi"
            "codespell"
            "crosstool-ng"
            "fpp"
            "fzf"
            "gh"
            "git-delta"
            "git-open"
            "git-spice"
            "gnu-sed"
            "gnupg"
            "mas"
            "maturin"
            "nox"
            "openssl@3"
            "pre-commit"
            "pinentry"
            "pkgconf"
            "ruff"
            "telnet"
            "uv"
          ];
          casks = [
            "1password-cli"
            "lm-studio"
            "rio"
            "zed"
          ];
        };
    };
  in
  {
    darwinConfigurations."mac-mini" = nix-darwin.lib.darwinSystem {
      modules = [
         configuration
      ];
    };
  };
}
