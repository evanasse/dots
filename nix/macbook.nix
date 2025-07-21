# studio system config

{ self, pkgs, ... }: rec {
  nixpkgs.config.allowUnfree = true;

  system.primaryUser = "evanasse";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      # CLI tools
      pkgs.bottom
      pkgs.delta
      pkgs.fd
      pkgs.fzf
      pkgs.ripgrep
      pkgs.starship
      pkgs.stow
      # Programming
      pkgs.aider-chat
      pkgs.gleam
      pkgs.lua-language-server
      pkgs.neovim
      pkgs.nil
      pkgs.uv
      # GUI apps
      pkgs.discord
      pkgs.wezterm
      # OS appearance
      pkgs.aerospace
      pkgs.sketchybar
    ];

  homebrew = {
    enable = true;
    brews = [
      "erlang"
    ];
    casks = [
      "1password"
      "desktoppr"
      "epic-games"
      "firefox"
      "librewolf"
      "steam"
      "vial"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

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
    NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
    NSGlobalDomain.AppleMetricUnits = 1; # Yes, use metric system.
    NSGlobalDomain."com.apple.sound.beep.feedback" = 0; # No sound feedback on volume change
    NSGlobalDomain."com.apple.sound.beep.volume" = 0.0; # No bell
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
    path_wallpaper = ./wallpaper.jpg;
    path_aerospace_plist = ../resources/launch-agents/bobko.aerospace.plist;
  in
  ''
    sudo -u ${username} echo >&2 "Setting wallpaper... (${path_wallpaper})"
    sudo -u ${username} /usr/local/bin/desktoppr ${path_wallpaper}

    sudo -u ${username} echo >&2 "Writing launch agents..."
    sudo -u ${username} sh -c 'mkdir -p /Users/${username}/Library/LaunchAgents'
    sudo -u ${username} sh -c 'PATH_APP=${pkgs.aerospace}/Applications/AeroSpace.app/Contents/MacOS/AeroSpace; cat ${path_aerospace_plist} | sed "s%\$PATH_APP%$PATH_APP%" > /Users/${username}/Library/LaunchAgents/bobko.aerospace.plist'

    sudo -u ${username} echo >&2 "Linking AeroSpace config..."
    sudo -u ${username} sh -c 'ln -s /Users/${username}/.config/aerospace/aerospace-macbook.toml /Users/${username}/.config/aerospace/aerospace.toml'
  '';
}
