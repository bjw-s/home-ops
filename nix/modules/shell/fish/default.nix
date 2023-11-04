{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.shell.fish;
in {
  options.modules.shell.fish = { enable = mkEnableOption "fish"; };

  config = mkIf cfg.enable {
    programs.fish.enable = true;

    modules.shell.starship.enable = true;

    home.manager = {
      programs.zoxide.enable = true;
      programs.fish = {
        enable = true;
        plugins = [
          { name = "done"; src = pkgs.fishPlugins.done.src; }
          { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
          {
            name = "zoxide";
            src = pkgs.fetchFromGitHub {
              owner = "kidonng";
              repo = "zoxide.fish";
              rev = "bfd5947bcc7cd01beb23c6a40ca9807c174bba0e";
              sha256 = "Hq9UXB99kmbWKUVFDeJL790P8ek+xZR5LDvS+Qih+N4=";
            };
          }
        ];
      };
    };
  };
}
