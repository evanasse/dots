{
  description = "nix-darwin systems flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    username_studio = "evanasse";
    username_macbook = "etiole";
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#studio
    darwinConfigurations = {
      studio = nix-darwin.lib.darwinSystem {
        modules = [
          ./studio.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = username_studio;
            };
          }
        ];
        specialArgs = { inherit self; };
      };
      macbook = nix-darwin.lib.darwinSystem {
        modules = [
          ./macbook.nix
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon only
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = username_macbook;
            };
          }
        ];
        specialArgs = { inherit self; };
      };
    };
  };
}
