{
  self,
  configurationDir,
  hostType,
  stateVersion,
  hostPlatform,
  ...
}:
{
  imports = [
    "${self}/common/modules"
    "${self}/common/overlays"
    "${self}/system/${hostType}/modules"
    "${self}/system/host/${configurationDir}"
    "${self}/system/host/${configurationDir}/modules"
    "${self}/system/host/${configurationDir}/overlays"
  ];

  system = {
    inherit stateVersion;
  };
  nixpkgs = {
    inherit hostPlatform;
  };
}
