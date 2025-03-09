{pkgs, vars, ...}:{
  home.packages = with pkgs; [
    prismlauncher
    clonehero
    libgpod
    blender-hip
    beatsabermodmanager
    libimobiledevice
    mpc
    strawberry
    kanshi
    emacs
    comma
    openscad
    openutau
    wlr-randr
    grim
    slurp
    grimblast
    swaynotificationcenter
    udiskie
    gtklock
    swaybg
    gzdoom
    fzf
    openrct2
    wl-clipboard
    brightnessctl
    nemo
    xfce.ristretto
    xfce.tumbler
    inkscape
    hyfetch
    fastfetch
    pamixer
    pavucontrol
    gimp
    tetrio-desktop
    timidity
    transmission_4-qt
    vesktop
    webcord-vencord
    gamescope
    vlc
    playerctl
    firefox
    v4l-utils
  ] ++ (if !vars.isNixOS then [nixgl.nixGLIntel] else []);
}
