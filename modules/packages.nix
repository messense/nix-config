{ pkgs, config, ... }:
{
  environment.systemPackages = [
    pkgs.bat
    pkgs.btop
    pkgs.cmake
    pkgs.delta
    pkgs.direnv
    pkgs.gti
    pkgs.helix
    pkgs.htop
    pkgs.hyperfine
    pkgs.jq
    pkgs.mkalias
    pkgs.nil # Language server for Nix
    pkgs.nixfmt-rfc-style
    pkgs.patchelf
    pkgs.pre-commit
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

  system.activationScripts.applications.text =
    let
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

  homebrew = {
    enable = true;
    # onActivation.cleanup = "uninstall";

    taps = [ "messense/macos-cross-toolchains" ];
    brews = [
      "aarch64-unknown-linux-gnu"
      "bindgen"
      "cargo-zigbuild"
      "cbindgen"
      "cffi"
      "codespell"
      "crosstool-ng"
      "fpp"
      "gh"
      "git-open"
      "git-spice"
      "gnu-sed"
      "gnupg"
      "mas"
      "maturin"
      "nox"
      "openssl@3"
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
}
