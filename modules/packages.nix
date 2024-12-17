{ pkgs, config, ... }:
{
  environment.systemPackages = [
    pkgs.bat
    pkgs.btop
    pkgs.cmake
    pkgs.codespell
    pkgs.delta
    pkgs.direnv
    pkgs.fpp
    pkgs.git-open
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
    pkgs.protobuf_29
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
      "crosstool-ng"
      "gh"
      "git-spice"
      "gnu-sed"
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
      "lm-studio"
      "rio"
      "warp"
      "zed"
    ];
    masApps = {
      "Apple Remote Desktop" = 409907375;
      "Apple Developer" = 640199958;
      Stash = 1596063349;
      TestFlight = 899247664;
      WeChat = 836500024;
      "Windows App" = 1295203466;
      WhatsApp = 310633997;
    };
  };
}
