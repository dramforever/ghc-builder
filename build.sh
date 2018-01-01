set -e

export LANG=C

cd ghc

configurePhase
patchPhase
buildPhase
installPhase
fixupPhase
