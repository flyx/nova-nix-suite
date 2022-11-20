This extension adds support for [Nix][1], including:

 * Syntax highlighting (via [tree-sitter-nix][2])
 * Language Server ([nil][3] by default, configurable)
 * Formatting (via [nixfmt][4])

## Roadmap

If possible, future features could include

 * import the `PATH` of a `nix develop` shell into Nova to get access to development dependencies specified via `flake.nix`.
 * build packages specified in `flake.nix` from within Nova.
 * get `bash` highlighting support in build phases (currently not possible because Nova's `shell` syntax is not TreeSitter).

## License

MIT

 [1]: https://nixos.org/
 [2]: https://github.com/cstrahan/tree-sitter-nix
 [3]: https://github.com/oxalica/nil
 [4]: https://github.com/serokell/nixfmt