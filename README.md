<p align="center">
<img src="https://raw.githubusercontent.com/isl-org/Open3D/master/docs/_static/open3d_logo_horizontal.png" width="320" />
</p>

# Open3D: A Modern Library for 3D Data Processing

<h4>
    <a href="http://www.open3d.org">Homepage</a> |
    <a href="http://www.open3d.org/docs">Docs</a> |
    <a href="http://www.open3d.org/docs/release/getting_started.html">Quick Start</a> |
    <a href="http://www.open3d.org/docs/release/compilation.html">Compile</a> |
    <a href="http://www.open3d.org/docs/release/index.html#python-api-index">Python</a> |
    <a href="http://www.open3d.org/docs/release/cpp_api.html">C++</a> |
    <a href="https://github.com/isl-org/Open3D-ML">Open3D-ML</a> |
    <a href="https://github.com/isl-org/Open3D/releases">Viewer</a> |
    <a href="http://www.open3d.org/docs/release/contribute/contribute.html">Contribute</a> |
    <a href="https://www.youtube.com/channel/UCRJBlASPfPBtPXJSPffJV-w">Demo</a> |
    <a href="https://github.com/isl-org/Open3D/discussions">Forum</a>
</h4>

Open3D is an open-source library that supports rapid development of software
that deals with 3D data. The Open3D frontend exposes a set of carefully selected
data structures and algorithms in both C++ and Python. The backend is highly
optimized and is set up for parallelization. We welcome contributions from
the open-source community.

[![Ubuntu CI](https://github.com/isl-org/Open3D/workflows/Ubuntu%20CI/badge.svg)](https://github.com/isl-org/Open3D/actions?query=workflow%3A%22Ubuntu+CI%22)
[![macOS CI](https://github.com/isl-org/Open3D/workflows/macOS%20CI/badge.svg)](https://github.com/isl-org/Open3D/actions?query=workflow%3A%22macOS+CI%22)
[![Windows CI](https://github.com/isl-org/Open3D/workflows/Windows%20CI/badge.svg)](https://github.com/isl-org/Open3D/actions?query=workflow%3A%22Windows+CI%22)

**Core features of Open3D include:**

* 3D data structures
* 3D data processing algorithms
* Scene reconstruction
* Surface alignment
* 3D visualization
* Physically based rendering (PBR)
* 3D machine learning support with PyTorch and TensorFlow
* GPU acceleration for core 3D operations
* Available in C++ and Python

For more, please visit the [Open3D documentation](http://www.open3d.org/docs).

## A Minimum Build

This fork of the <a href="https://github.com/isl-org/Open3D">Open3D repository</a> provides 
a lightweight build of the Open3D library.  This build includes only the core computational
modules and excludes the machine learning and visualization modules.

## Build Instructions

1. After first cloning the repository, intialize and update the third party submodules:
```
git submodule update --init --recursive

```

2. Run the build script to build Open3D dependencies and Open3D.
```
scripts/build-all

```

The build script installs Open3D dependencies in `./dependencies/install` and installs 
Open3D in `./install`.  These install directories can be copied to where they are needed.
