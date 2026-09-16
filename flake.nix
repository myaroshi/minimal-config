{
  description = "Tiny NixOS + IceWM system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.pentium = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        ./hardware-configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.frace = ./home.nix;
        }
      ];
    };
  };
}
