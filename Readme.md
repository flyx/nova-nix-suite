<h1 align="center">Nix Suite</h1>
<h4 align="center">A <a href="https://nova.app">Nova</a> extension for <a href="https://nixos.org">Nix</a> files</h4>

This repository contains the **Nix Suite**.
It is based on [nova-extension-utils][1].
This readme is developer documentation, the user documentation can be found [over here](/Readme-user.md).

## Building & Testing

This repository is a [Nix Flake][2], you'll need the Nix package manager installed.
To build the extension, use

    nix build --impure

This will generate a symlink `result` that will contain the extension.
Open that in a Nova window to test or publish it.
See [nova-extension-utils][1] for details.

## License

[MIT](License.md)



 [1]: https://github.com/flyx/nova-extension-utils
 [2]: https://nixos.wiki/wiki/Flakes