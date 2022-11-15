{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    nova-utils = {
      url = github:flyx/nova-extension-utils;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url      = github:numtide/flake-utils;
    tree-sitter-nix = {
      url = github:cstrahan/tree-sitter-nix;
      flake = false;
    }; 
  };
  outputs = {
    self, nixpkgs, nova-utils, utils, tree-sitter-nix
  }: utils.lib.eachSystem [
    utils.lib.system.x86_64-darwin
    utils.lib.system.aarch64-darwin
  ] (system: let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ nova-utils.overlays.default ];
    };
    syntax-lib = pkgs.buildNovaTreeSitterLib {
      langName = "nix";
      src = tree-sitter-nix;
    };
  in {
    packages.default = pkgs.buildNovaExtension {
      pname = "NixSuite";
      version = "0.1.0";
      src = self;
      identifier = "org.flyx.nix";
      organization = "Felix Krause";
      description = "TreeSitter-based extension for the Nix language";
      categories = [ "languages" ];
      license = "MIT";
      treeSitterLibs = [ syntax-lib ];
      derivationParams = {
        buildInputs = [ pkgs.gnused ];
        postInstall = ''
          ${pkgs.gnused}/bin/sed 's/injection.language "bash"/injection.language "shell"/g' ${tree-sitter-nix}/queries/injections.scm > $extDir/Queries/injections.scm
        '';
      };
      config = {
        languageServer = {
          title   = "Language Server";
          type    = "path";
          default = "nil";
        };
      };
      main = "main.js";
      entitlements = {
        process    = true;
      };
    };
  });
}