{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      (python3.withPackages (ps: [
        ps.mypy
        ps.pytest
        ps.ipykernel
        ps.pydantic
      ]))
    ];
  };
}
