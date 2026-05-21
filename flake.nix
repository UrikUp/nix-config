{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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

    mkPkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;

      overlays = import ./overlays {
        inherit inputs;
      };
    };

    mkHost = modules:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = modules ++ [
          {
            nixpkgs.overlays = import ./overlays {
              inherit inputs;
            };
          }
        ];
    };

    mkHome = modules:
      home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs;

        extraSpecialArgs = {
          inherit inputs;
        };

        inherit modules;
      };
  in {
    nixosConfigurations = {
      nixos = mkHost [
        ./hosts/desktop/configuration.nix

        stylix.nixosModules.stylix
        home-manager.nixosModules.default
        determinate.nixosModules.default
        agenix.nixosModules.default

      ];
      vps = mkHost [
        disko.nixosModules.disko          # Loads disko module safely
        ./hosts/vps/configuration.nix
        ./hosts/vps/hardware-configuration.nix
        determinate.nixosModules.default  # Optional: standardizes your nix daemon management
      ];
    };
    homeConfigurations = {
      "urik@nixos" = mkHome [
        ./home/home.nix
        stylix.homeModules.stylix
        inputs.nvf.homeManagerModules.default
        inputs.vicinae.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.spicetify
        inputs.agenix.homeManagerModules.default
      ];

      # "urik@vps" = mkHome [ ];
    };
  };
}
