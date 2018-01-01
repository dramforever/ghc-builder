#! /usr/bin/env nix-shell
#! nix-shell '<nixpkgs>' -A haskell.compiler.ghcHEAD -i bash

set -e

cd ghc
configurePhase
patchPhase
buildPhase
installPhase
fixupPhase
