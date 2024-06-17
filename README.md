# Build spigot

Build spigot server on docker container.

## Requirements

- curl
- jq
- docker

## Usage

```
./build.sh [<SPIGOT_REV (Default: Latest release version)> [--batch]]
```

### Examples

```bash
./build.sh
```

```bash
./build.sh 1.21
```

```bash
./build.sh 1.21 --batch
```
