{config, pkgs, lib, inputs, vars, ...}:{
  imports = [
    #home-manager modules
    inputs.nix-index-database.hmModules.nix-index
    inputs.nixvim.homeManagerModules.default
    inputs.catppuccin.homeManagerModules.catppuccin
    #aux files to make finding specific things easier
    ./sway.nix
    ./theming.nix
    ./nixvim
    ./packages.nix #general user packages not managed by home-manager but i want to install via hm anyways
  ];
  home = rec {
    username = vars.user; #this is set in flake.nix 
    homeDirectory = "/home/${username}"; #change this if you use a non-standard home dir
    stateVersion = "23.11";
    file = {
      ".config/waybar/config".source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/.config/nixos/home/waybar/config";
      ".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/.config/nixos/home/waybar/style.css";
    };
  };
  programs.home-manager.enable = (!vars.isNixOS); #value is set in flake.nix
  programs.foot = {
    enable = true;
    settings.main.font = "monospace:size=14";
    #settings.colors.alpha = "0.8";
  };
  programs.ncmpcpp = {
    enable = true;
    settings = {
      tags_separator = ";";
    };
  };
  services.mpd = {
    enable = true;
    musicDirectory = "/home/${vars.user}/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
	name "default pipewire"
      }
    '';
  };
  services.mpd-mpris = {
    enable = true;
  };

#  xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";

#  xdg.configFile."openvr/openvrpaths.vrpath".text = ''
#  {
#    "config" :
#    [
#      "${config.xdg.dataHome}/Steam/config"
#    ],
#    "external_drivers" : null,
#    "jsonid" : "vrpathreg",
#    "log" :
#    [
#      "${config.xdg.dataHome}/Steam/logs"
#    ],
#    "runtime" :
#    [
#      "${pkgs.opencomposite}/lib/opencomposite"
#    ],
#    "version" : 1
#  }
#'';

  services.arrpc.enable = true;

  programs.waybar = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName = "cydiralis";
    userEmail = "cydiralis@proton.me";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      init.defaultBranch = "main";
    };
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };
}
