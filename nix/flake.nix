{
  description = "etiole nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
	  pkgs.bottom
	  pkgs.delta
	  pkgs.discord
	  pkgs.fzf
	  pkgs.gleam
	  pkgs.ripgrep
	  pkgs.starship
	  pkgs.stow
          pkgs.neovim
	  pkgs.neofetch
        ];

      homebrew = {
        enable = true;
	brews = [
	  "mas"
	  "erlang"
	];
        casks = [
	  "nikitabobko/tap/aerospace"
	  "librewolf"
          "steam"
	  "ollama"
	  "wezterm"
        ];
	masApps = {
	};
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        pkgs.nerd-fonts.ubuntu-mono
      ];

      system.defaults = {
	controlcenter.BatteryShowPercentage = true;
	dock.autohide = true;
	dock.persistent-apps = [];
	dock.persistent-others = [];
	dock.show-recents = false;
	finder.FXPreferredViewStyle = "clmv";
	loginwindow.GuestEnabled = false;
	NSGlobalDomain.AppleICUForce24HourTime = true;
	NSGlobalDomain.AppleInterfaceStyle = "Dark";
	NSGlobalDomain.KeyRepeat = 2;
	NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#etiole
    darwinConfigurations."etiole" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "etiole";
          };
        }
      ];
    };
  };
}
