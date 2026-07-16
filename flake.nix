{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
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
      ...
    }@inputs:
    let
      mkHostModule = host: [
        ./hosts/${host}/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
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

      system = "x86_64-linux";
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
