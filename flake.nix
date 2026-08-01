{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      mkHostModule = host: [
        ./hosts/${host}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {
            pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
          };
          home-manager.users.finns = import ./hosts/${host}/home.nix;
        }
      ];

      mkNixosConfiguration =
        host:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = (mkHostModule host);
        };

      hosts = [
        "KLOMPXI"
        "KLOMPXL"
      ];
    in
    {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts mkNixosConfiguration;
      devShells.${system} = import ./devshells { pkgs = nixpkgs.legacyPackages.${system}; };
    };
}
