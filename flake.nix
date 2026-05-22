{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
 
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";

    nix-cachyos-kernel = {
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate.url =
      "https://flakehub.com/f/DeterminateSystems/determinate/*";

    freesmlauncher.url =
      "github:FreesmTeam/FreesmLauncher";
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    agenix,
    determinate,
    disko,
    ...
  }@inputs:

let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = import ./overlays { inherit inputs; };
    };

  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desktop/configuration.nix
          stylix.nixosModules.stylix
          determinate.nixosModules.default
          agenix.nixosModules.default
        ];
      };

      vps = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          disko.nixosModules.disko
          ./hosts/vps/configuration.nix
          ./hosts/vps/hardware-configuration.nix
        ];
      };
    };

    homeConfigurations = {
      "urik@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home/home.nix
          stylix.homeModules.stylix
          inputs.nvf.homeManagerModules.default
          inputs.vicinae.homeManagerModules.default
          inputs.spicetify-nix.homeManagerModules.spicetify
          inputs.agenix.homeManagerModules.default
        ];
      };
    };
  };
}
