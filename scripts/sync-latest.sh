#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-1_1UT15}"
BASE="https://test.tuffis.online/files/${VERSION}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$ROOT/files/${VERSION}/WASM" "$ROOT/files/${VERSION}/JS/plugins"

download() {
  local dest="$1" url="$2"
  echo "Downloading $dest..."
  curl -fsSL "$url" -o "$dest"
}

for f in index.html bootstrap.js assets.epw favicon.png Tuff_Client_Offline_WASM.html; do
  download "$ROOT/files/${VERSION}/WASM/$f" "$BASE/WASM/$f"
done

for f in index.html classes.js favicon.png Tuff_Client_JS.html; do
  download "$ROOT/files/${VERSION}/JS/$f" "$BASE/JS/$f"
done

for f in EventBus.js PluginManager.js PluginAPI.js PluginRuntime.js PluginBootstrap.js; do
  download "$ROOT/files/${VERSION}/JS/plugins/$f" "$BASE/JS/plugins/$f"
done

echo "Done. Synced build ${VERSION} to files/${VERSION}/"
