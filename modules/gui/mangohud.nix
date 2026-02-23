{
  config,
  pkgs,
  isNixOS,
  ...
}:

{
  catppuccin.mangohud.enable = false;

  programs.mangohud = {
    enable = true;
    package = if isNixOS then pkgs.mangohud else (pkgs.runCommand "dummy-mangohud" { } "mkdir $out");
  };

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    legacy_layout=false
    background_alpha=0.6
    round_corners=10
    background_color=1E1E2E
    font_size=24
    text_color=CDD6F4
    position=top-right
    no_display
    hud_compact

    pci_dev=0:03:00.0
    table_columns=2

    gpu_text=GPU
    gpu_stats
    gpu_voltage
    gpu_core_clock
    gpu_mem_clock
    gpu_temp
    gpu_mem_temp
    gpu_fan
    gpu_power
    gpu_color=A6E3A1
    gpu_name

    cpu_text=CPU
    cpu_stats
    cpu_load_change
    cpu_load_value=50,90
    cpu_load_color=A6E3A1,FAB387,F38BA8
    cpu_mhz
    cpu_temp
    cpu_power
    cpu_color=89B4FA

    vram
    vram_color=A6E3A1
    ram
    ram_color=F5C2E7

    io_stats
    io_read
    io_write
    io_color=CDD6F4

    fps
    fps_metrics=avg,0.01
    frame_timing
    frametime_color=A6E3A1
    fps_limit_method=late
    toggle_fps_limit=Shift_L+F1
    fps_limit=0
    resolution
    gamemode
    fps_color_change
    fps_color=F38BA8,F9E2AF,A6E3A1
    fps_value=30,60

    log_duration=30
    autostart_log=0
    log_interval=100
    toggle_logging=Shift_L+F2
    blacklist=pamac-manager,lact,ghb,bitwig-studio,ptyxis,yumex
  '';
}
