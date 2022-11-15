const LanguageServer = require("language-server.js").LanguageServer;
const Config = require("config.js").Config;

let langserver = null;
let config = null;

exports.activate = () => {
  console.log("Activating Nix Suite");
  config = new Config();
  langserver = new LanguageServer("org.flyx.nix", {
    syntaxes: ["nix"]
  }, config.languageServer);
}

exports.deactivate = () => {
  console.log("Deactivating Nix Suite");
  langserver.deactivate();
  langserver = null;
}