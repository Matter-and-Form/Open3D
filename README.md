## A Minimal Open3D Build

This fork provides a minimal build of the <a href="https://github.com/isl-org/Open3D">Open3D library</a>.
This build includes only the core computational modules and excludes the machine learning and visualization modules.

## Build Instructions

1. After first cloning the repository, initialize and update the third party submodules:
```
git submodule update --init --recursive

```

2. Run the build script to build Open3D and its dependencies.
```
scripts/build-all

```

The build script installs Open3D dependencies in `./dependencies/install` and installs 
Open3D in `./install`.  These install directories can be copied to where they are needed.