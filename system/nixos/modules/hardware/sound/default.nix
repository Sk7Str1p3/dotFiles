{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.module.hardware.sound;
in
{
  # Declare Options
  options = {
    module.hardware.sound = {
      enable = mkEnableOption "Enable sound support";
    };
  };

  # Implementation
  config = mkIf cfg.enable {
    # Enable RTKit for real-time priority
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      # Set Pipewire as main sound server
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      # Enable Jack support
      jack.enable = true;
      # Enable PulseAudio compatibility
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}
