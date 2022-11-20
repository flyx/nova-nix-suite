{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nova-utils = {
      url = "github:flyx/nova-extension-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
    tree-sitter-nix = {
      url = "github:cstrahan/tree-sitter-nix";
      flake = false;
    };
  };
  outputs = { self, nixpkgs, nova-utils, utils, tree-sitter-nix }:
    utils.lib.eachSystem [
      utils.lib.system.x86_64-darwin
      utils.lib.system.aarch64-darwin
    ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nova-utils.overlays.default ];
        };
        syntax-lib = pkgs.buildNovaTreeSitterLib {
          langName = "nix";
          src = tree-sitter-nix;
        };
        artwork = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/376ed4ba8dc2e611b7e8a62fdc680967ead5bd87/logo/nix-snowflake.svg";
          sha256 = "14mbpw8jv1w2c5wvfvj8clmjw0fi956bq5xf9s2q3my14far0as8";
        };
      in {
        packages.default = pkgs.buildNovaExtension {
          name = "Nix Suite";
          version = "0.1.0";
          src = self;
          identifier = "org.flyx.nix";
          organization = "Felix Krause";
          description = "TreeSitter-based extension for the Nix language";
          categories = [ "languages" ];
          license = "MIT";
          treeSitterLibs = [ syntax-lib ];
          derivationParams = {
            buildInputs = with pkgs; [ gnused librsvg ];
            postInstall = ''
              ${pkgs.gnused}/bin/sed 's/injection.language "bash"/injection.language "shell"/g' ${tree-sitter-nix}/queries/injections.scm > $extDir/Queries/injections.scm
              ${pkgs.librsvg}/bin/rsvg-convert -w 32 -h 32 ${artwork} -o $extDir/extension.png
              ${pkgs.librsvg}/bin/rsvg-convert -w 64 -h 64 ${artwork} -o $extDir/extension@2x.png
            '';
          };
          config = {
            languageServer = {
              title = "Language Server";
              type = "path";
              default = "nil";
            };
            formatOnSave = {
              title = "Format on Save (requires nixfmt)";
              type = "boolean";
              default = false;
            };
          };
          main = "main.js";
          entitlements = { process = true; };
        };
      });
}
