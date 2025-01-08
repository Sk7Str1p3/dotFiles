{pkgs, ...}: {
  gtk = {
    enable = true;
    iconTheme = {
      name = "Tela-circle-black";
      package = pkgs.tela-circle-icon-theme.override {
        colorVariants = [
	  "black"
	];
      };
    };
  };
}
