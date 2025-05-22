{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    utils.url = github:ursi/flake-utils;
    hooks.url = github:cachix/git-hooks.nix;
    purs-nix.url = github:purs-nix/purs-nix;
    ps-tools.follows = "purs-nix/ps-tools";
    option = {
      url = "github:jmatsushita/purescript-option/8d0984"; 
      flake = false;
    };
  };

  outputs = { self, utils, ... }@inputs:
    utils.apply-systems
      { inherit inputs; }
      ({ pkgs, system, ... }@ctx:
        let
          # frontend
          inherit (pkgs) nodejs;
          purs-nix = inputs.purs-nix { inherit system; };
          inherit (ctx.ps-tools.for-0_15) purescript purs-tidy purescript-language-server;
          # TODO use option from official index
          option = purs-nix.build { 
            name = "option";
            src.path = inputs.option;
            info.dependencies = [ "aff" "argonaut-codecs" "argonaut-core"    "codec" "codec-argonaut" "datetime" "effect" "either" "enums" "foldable-traversable" "foreign" "foreign-object" "functors" "identity" "lists" "maybe" "prelude" "record" "simple-json" "spec" "transformers" "tuples" "unsafe-coerce"];
          };
          ps =
            purs-nix.purs
              {
                dir = ./.;
                dependencies =
                  with purs-nix.ps-pkgs;
                  [
                    prelude
                    option
                  ];
                inherit purescript nodejs;
              };
          # helpers
          hooks = inputs.hooks.lib.${system}.run {
            src = ./src;
            hooks = {
              # hook for frontend
              purs-tidy = {
                enable = true;
                package = purs-tidy;
              };
            };
          };
        in 
         {
          packages.default = ps.output { };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # TODO remove compiled output from the repo
              (ps.command { })
              purescript-language-server
            ];
            shellHook = ''
              ${hooks.shellHook}
              shopt -s expand_aliases
              alias log_='printf "\033[1;32m%s\033[0m\n" "$@"'
              alias info_='printf "\033[1;34m[INFO] %s\033[0m\n" "$@"'
              alias warn_='printf "\033[1;33m[WARN] %s\033[0m\n" "$@"'

              log_ "Welcome to TypeApp shell."
              info_ "Available commands: purs-nix"
            '';
          };
         });
  nixConfig = {
    accept-flake-config = true;
    extra-experimental-features = "nix-command flakes";
  };
}
