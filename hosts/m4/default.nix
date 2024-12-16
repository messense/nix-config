{ username, ... }:
{
  imports = [
    ../../modules/system.nix
    ../../modules/packages.nix
    ../../modules/defaults.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Declare the user that will be running `nix-darwin`.
  users.users.messense = {
    name = "${username}";
    home = "/Users/${username}";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
}
