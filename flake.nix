{
  description = "Dev Shell for Test Driven Development";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    pythonEnv = pkgs.python312.withPackages (ps: with ps; [pip numpy]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        pythonEnv
        pkgs.virtualenv
        pkgs.firefox
        pkgs.geckodriver
      ];

      shellHook = ''
        echo "Welcome to the Test Driven Development Shell"
        export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
      '';
    };
  };
}
