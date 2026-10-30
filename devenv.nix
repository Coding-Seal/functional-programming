{ pkgs, lib, config, inputs, ... }:

{
  # https://devenv.sh/packages/
  packages = [ pkgs.swi-prolog pkgs.just pkgs.typst ];

  # https://devenv.sh/basics/
  enterShell = ''
    swipl --version
  '';
}
