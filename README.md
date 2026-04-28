# XerahS Pixelfox Plugin

Official Pixelfox uploader plugin for XerahS.

The plugin uploads images to Pixelfox via API-key authenticated direct upload sessions. It supports optional album assignment, NSFW marking, and Pixelfox processing modes `default` and `original_only`.

## Requirements

- .NET 10 SDK
- A local XerahS checkout
- A Pixelfox API key

By default the project expects the XerahS checkout next to this repository:

```text
/home/dev/Workspace/Github/
  XerahS/
  xerahs-pixelfox-plugin/
```

If your XerahS checkout is somewhere else, pass `XerahSRepoRoot` explicitly:

```bash
dotnet build src/Pixelfox.Plugin/XerahS.Pixelfox.Plugin.csproj -c Release -m:1 -p:XerahSRepoRoot=/path/to/XerahS
```

## Build

```bash
dotnet build src/Pixelfox.Plugin/XerahS.Pixelfox.Plugin.csproj -c Release -m:1
```

## Package

Create an installable `.xsdp` package:

```bash
./scripts/package.sh
```

This writes:

```text
dist/XerahS.Pixelfox.Plugin-1.0.0.xsdp
dist/XerahS.Pixelfox.Plugin-1.0.0.xsdp.sha256
```

You can override the version or XerahS checkout path:

```bash
VERSION=1.0.1 XERAHS_REPO_ROOT=/path/to/XerahS ./scripts/package.sh
```

## Release

1. Create a GitHub release, for example `v1.0.0`.
2. Upload `dist/XerahS.Pixelfox.Plugin-1.0.0.xsdp` as a release asset.
3. Copy the SHA-256 hash from `dist/XerahS.Pixelfox.Plugin-1.0.0.xsdp.sha256`.
4. Provide the release asset URL and checksum for the XerahS community plugin registry entry.

Expected release asset URL shape:

```text
https://github.com/ManuelReschke/xerahs-pixelfox-plugin/releases/download/v1.0.0/XerahS.Pixelfox.Plugin-1.0.0.xsdp
```

## Registry Metadata

The plugin manifest uses:

```json
{
  "pluginId": "pixelfox",
  "name": "Pixelfox"
}
```

The community registry entry must use the same `pluginId`.

## License

GPL v3, matching XerahS and the plugin source file headers.
