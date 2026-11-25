#!/bin/sh
set -eu
PROJECT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/app" && pwd)
cd "$PROJECT_DIR"
# Keep generated builds outside cloud-synced Documents to allow Apple signing.
PROJECT_KEY=$(printf '%s' "$PROJECT_DIR" | cksum | awk '{print $1}')
BUILD_CACHE="$HOME/Library/Caches/SomBom/$PROJECT_KEY/build"
if [ ! -L build ]; then
  mkdir -p "$(dirname "$BUILD_CACHE")"
  if [ -d build ] && [ ! -e "$BUILD_CACHE" ]; then
    mv build "$BUILD_CACHE"
  elif [ -e build ]; then
    echo 'Há duas pastas de build. Preserve os arquivos e ajuste o cache antes de continuar.' >&2
    exit 1
  fi
  mkdir -p "$BUILD_CACHE"
  ln -s "$BUILD_CACHE" build
fi
# Prevent Xcode's package probes from reading cloud-only parent Git metadata.
export GIT_CEILING_DIRECTORIES="$PROJECT_DIR"
if command -v flutter >/dev/null 2>&1; then
  FLUTTER_BIN=$(command -v flutter)
elif [ -x "$HOME/development/flutter/bin/flutter" ]; then
  FLUTTER_BIN="$HOME/development/flutter/bin/flutter"
else
  echo 'Flutter não encontrado. Adicione o SDK ao PATH.' >&2
  exit 1
fi
if [ "$#" -eq 0 ]; then
  set -- -d macos
fi
exec "$FLUTTER_BIN" run "$@"
