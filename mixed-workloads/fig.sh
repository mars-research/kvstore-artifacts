#!/bin/bash
#
KVSTORE_BASE=/opt/kvstore
KVSTORE_DIR=${KVSTORE_BASE}/kvstore
KVSTORE_ARTIFACTS=${HOME}/kvstore-artifacts
KVSTORE_BUILD_DIR=${KVSTORE_DIR}/build

PS2PDF_FLAGS="-dEPSCrop -dPDFSETTINGS=/printer -dColorConversionStrategy=/RGB -dProcessColorModel=/DeviceRGB -dEmbedAllFonts=true -dSubsetFonts=true -dMaxSubsetPct=100"

run_fig() {
  pushd ${KVSTORE_BUILD_DIR}
  python ../scripts/generate-rw-runs.py $1 > runs.sh
  sh -x runs.sh
  popd
}

plot_fig() {
  echo "Plotting with gnuplot..."
  nix-shell -p gnuplot --command "gnuplot $1.gnu"
  if [[ $? == 0 && -f $1.eps ]]; then
    echo "Converting EPS -> PDF"
    nix-shell -p ghostscript --command "ps2pdf14 ${PS2PDF_FLAGS} $1.eps $1.pdf"
  fi
}

run_fig 0.01
python pkg.py ${KVSTORE_BUILD_DIR} > uniform.csv
run_fig 1.09
python pkg.py ${KVSTORE_BUILD_DIR} > skewed.csv
plot_fig rw-uniform
plot_fig rw-skewed