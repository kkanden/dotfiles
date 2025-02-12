{
  lib,
  pkgs,
  air,
  crane,
  ...
}: let
  mkRustPkg = src: let
    craneLib = crane.mkLib pkgs;
    clean-src = craneLib.cleanCargoSource src;
    commonArgs = {
      strictDeps = true;

      # buildInputs =
      #   [
      #   ]
      #   ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      #     # Additional darwin specific inputs can be set here
      #   ];
    };

    cargoArtifacts = craneLib.buildDepsOnly commonArgs;

    individualCrateArgs =
      commonArgs
      // {
        inherit cargoArtifacts;
        inherit (craneLib.crateNameFromCargoToml {src = clean-src;}) version;
        # NB: we disable tests since we'll run them all via cargo-nextest
        doCheck = false;
      };
  in
    craneLib.buildPackage (individualCrateArgs
      // {
        src = src;
        pname = "air";
        cargoExtraArgs = "-p air";
      });
in
  mkRustPkg "${air}"
