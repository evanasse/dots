# studio system config

{ self, pkgs, ... }: rec {
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "evanasse";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.aider-chat
      pkgs.bottom
      pkgs.delta
      pkgs.discord
      pkgs.fd
      pkgs.fzf
      pkgs.gleam
      pkgs.neofetch
      pkgs.neovim
      pkgs.ripgrep
      pkgs.starship
      pkgs.stow
      pkgs.uv
    ];
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  homebrew = {
    enable = true;
    brews = [
      "mas"
      "erlang"
    ];
    taps = [
      "nikitabobko/tap"
    ];
    casks = [
      "1password"
      "aerospace"
      "desktoppr"
      "librewolf"
      "ollama"
      "steam"
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
    NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
    NSGlobalDomain.AppleMetricUnits = 1; # Yes, use metric system.
    NSGlobalDomain."com.apple.sound.beep.feedback" = 0; # No sound feedback on volume change
    NSGlobalDomain."com.apple.sound.beep.volume" = 0.0; # No bell
    ".GlobalPreferences"."com.apple.mouse.scaling" = 0.85; # Mouse speed
  };

  system.startup.chime = false;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.activationScripts.postActivation.text = let
    username = system.primaryUser;
    wallpaper_filepath = ./wallpaper.jpg;
  in
  ''
    sudo -u ${username} echo >&2 "Setting wallpaper..."
    sudo -u ${username} /usr/local/bin/desktoppr ${wallpaper_filepath}
  '';
}
