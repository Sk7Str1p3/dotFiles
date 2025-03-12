<div align="center"><img src=./assets/logo.png width=300></div>
<h1 align="center">Sk7Str1p3's Flake</h1>

## 🌟 Features

- ❄️ <span style="color:#CBA6F7">Flakes</span> \\\ declarative management of system dependencies
- 🏠 Home-Manager \\\ $HOME configuration with Nix modules
- 💽 Disko \\\ disk configuration via Nix
- 🧽 Impermanence \\\ clear state and not declarative junk
- 🍎 Nix-Darwin \\\ MacOS with Nix modules <span style="color:#f38ba8">(TODO)</span>
- 😻 Catppuccin \\\ Soothing pastel theme for everything
- 🔐 Sops \\\ declarative secrets management

## 🗃 File structure
- [flake.nix](flake.nix) \\\ repo core
- [flake-parts](flake-parts/) \\\ flake modules
- [system](system/) \\\ system configuration core
  - [hosts](system/hosts/) \\\ machine configurations
    - [\<name>](system/hosts/pcnix) \\\ configuration of specific machine
      - [modules](system/hosts/pcnix/modules/) \\\ additional modules
        - [hardware](system/hosts/pcnix/hardware/) \\\ hardware configuration
  - [nixos](system/nixos/) \\\ configuration modules for NixOS
- [user](user/) \\\ user configuration including home-manager
  - [home-modules](users/modules/) \\\ home-manager modules
  - [overlays](users/overlays/) \\\ home overlays
  - [users](users/users) \\\ user configurations
    - [\<name>](users/users/Sk7Str1p3/) \\\ per-user configuration
      - [sysInfo.nix](users/users/Sk7Str1p3/sysInfo.nix) \\\ user info should be declared system-wide
      - [modules](users/users/Sk7Str1p3/modules/) \\\ additional modules for home-manager

## 📸 Preview

Here's some screenshots of my workspace (work in progress)

### 💧 Hyprland
<img src=./assets/hyprland/main.png>
<img src=./assets/hyprland/vsc.png>
<img src=./assets/hyprland/all.png>
