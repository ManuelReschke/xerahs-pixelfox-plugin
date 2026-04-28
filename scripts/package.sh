#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
XERAHS_REPO_ROOT="${XERAHS_REPO_ROOT:-"$ROOT_DIR/../XerahS"}"
XERAHS_REPO_ROOT="${XERAHS_REPO_ROOT%/}/"
CONFIGURATION="${CONFIGURATION:-Release}"
VERSION="${VERSION:-1.0.0}"

PLUGIN_PROJECT="$ROOT_DIR/src/Pixelfox.Plugin/XerahS.Pixelfox.Plugin.csproj"
PLUGIN_OUTPUT="$ROOT_DIR/src/Pixelfox.Plugin/bin/$CONFIGURATION/net10.0"
PACKAGE_INPUT="$ROOT_DIR/artifacts/package/pixelfox"
DIST_DIR="$ROOT_DIR/dist"
PACKAGE_PATH="$DIST_DIR/XerahS.Pixelfox.Plugin-$VERSION.xsdp"

dotnet build "$PLUGIN_PROJECT" -c "$CONFIGURATION" -m:1 -p:XerahSRepoRoot="$XERAHS_REPO_ROOT"

rm -rf "$PACKAGE_INPUT"
mkdir -p "$PACKAGE_INPUT" "$DIST_DIR"

cp "$PLUGIN_OUTPUT/XerahS.Pixelfox.Plugin.dll" "$PACKAGE_INPUT/"
if [ -f "$PLUGIN_OUTPUT/XerahS.Pixelfox.Plugin.pdb" ]; then
  cp "$PLUGIN_OUTPUT/XerahS.Pixelfox.Plugin.pdb" "$PACKAGE_INPUT/"
fi
cp "$PLUGIN_OUTPUT/plugin.json" "$PACKAGE_INPUT/"

dotnet run --project "$XERAHS_REPO_ROOT/src/desktop/tools/XerahS.PluginExporter/XerahS.PluginExporter.csproj" -- "$PACKAGE_INPUT" -o "$PACKAGE_PATH"

sha256sum "$PACKAGE_PATH" | tee "$PACKAGE_PATH.sha256"
