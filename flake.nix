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
    username = "messense";
    specialArgs =
      inputs
      // {
        inherit username;
      };
  in
  {
    darwinConfigurations."mac-mini" = nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      modules = [
        ./hosts/mac-mini
      ];
    };
  };
}
