const LanguageServer = require("language-server.js").LanguageServer;
const Config = require("config.js").Config;
const Formatter = require("formatter.js").Formatter;

let config = null;

exports.activate = () => {
  if (nova.inDevMode()) console.log("Activating Nix Suite");
  config = new Config();
  nova.subscriptions.add(new LanguageServer(
    "org.flyx.nix", {
      syntaxes: ["nix"]
    }, config.languageServer
  ));
  nova.subscriptions.add(new Formatter(
    "org.flyx.nix.format",
    "nixfmt", [],
    [ "nix" ],
    config.formatOnSave
  ));
}

exports.deactivate = () => {
  if (nova.inDevMode()) console.log("Deactivating Nix Suite");
}