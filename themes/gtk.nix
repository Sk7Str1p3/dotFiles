{pkgs, ...}: {
  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-purple";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = ["purple"];
      };
    };
  };
}
