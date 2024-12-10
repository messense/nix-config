{ username, agenix, ... }:
let
  system = "aarch64-darwin";
in
{
  imports = [
    ../../modules/system.nix
    ../../modules/packages.nix
  ];

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "${system}";

  # Declare the user that will be running `nix-darwin`.
  users.users.messense = {
    name = "${username}";
    home = "/Users/${username}";
  };

  # security.pam.enableSudoTouchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.systemPackages = [ agenix.packages.${system}.default ];
}
