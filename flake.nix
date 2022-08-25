{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils/master";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          pythonEnv = pkgs.python310.withPackages (ps: [
            ps.tqdm
            ps.requests
          ]);
        in {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              pythonEnv
              lzip
              sqlite
            ];
          };
        }
      );
}
