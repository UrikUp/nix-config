{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # quickshell = {
    #   url = "github:outfoxxed/quickshell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
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
  };

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./nixos/configuration.nix
        inputs.stylix.nixosModules.stylix
        # inputs.noctalia.nixosModules.default
        inputs.home-manager.nixosModules.default
        # inputs.mangowm.nixosModules.mango
        inputs.agenix.nixosModules.default
        { nixpkgs.overlays = import ./overlays { inherit inputs; }; }
      ];
    };

    homeConfigurations."urik@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        overlays = import ./overlays { inherit inputs; };
      };
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./home-manager/home.nix
        inputs.stylix.homeModules.stylix
        # inputs.catppuccin.homeModules.catppuccin
        inputs.nvf.homeManagerModules.default
        inputs.vicinae.homeManagerModules.default
        inputs.spicetify-nix.homeManagerModules.spicetify
        inputs.agenix.homeManagerModules.default
      ];
    };
  };
}
