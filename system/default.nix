{
  self,
  lib,
  machineDir,
  hostType,
  stateVersion,
  hostPlatform,
  ...
}: let
  machineConfigurationPath = "${self}/system/machine/${machineDir}";
  machineConfigurationPathExist = builtins.pathExists machineConfigurationPath;
  machineModulesPath = "${self}/system/machine/${machineDir}/modules";
  machineModulesPathExist = builtins.pathExists machineModulesPath;
in {
  imports =
    [
      "${self}/common/modules"
      "${self}/common/overlays"
      "${self}/system/${hostType}/modules"
    ]
    ++ lib.optional machineConfigurationPathExist machineConfigurationPath
    ++ lib.optional machineModulesPathExist machineModulesPath;

  system = {
    inherit stateVersion;
  };
  nixpkgs = {
    inherit hostPlatform;
  };
}
