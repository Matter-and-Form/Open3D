cmake_minimum_required(VERSION 3.16.0)

project(Open3D VERSION 0.15.2 DESCRIPTION "Open3D Library.")

# Build options
option(BUILD_SHARED_LIBS "Build Open3D as a shared library." ON)
option(OPEN3D_IS_SUBDIRECTORY "Build Open3D as a subdirectory in another project." OFF)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Include Open3D definitions
include(cmake-minimal/Definitions.cmake)

# Find dependency packages

# Built shared libraries
find_package(assimp 5.1 REQUIRED PATHS ${MFLIB_DEPENDENCIES_PATH}/assimp NO_DEFAULT_PATH)
find_package(Eigen3 3.4 REQUIRED PATHS ${MFLIB_DEPENDENCIES_PATH}/eigen NO_DEFAULT_PATH)

# Built static libraries
find_package(jsoncpp 1.5 REQUIRED PATHS ${OPEN3D_DEPENDENCIES_PATH}/jsoncpp NO_DEFAULT_PATH)
find_package(Qhull 8.0 REQUIRED PATHS ${OPEN3D_DEPENDENCIES_PATH}/qhull NO_DEFAULT_PATH)

# Apt packages
find_package(fmt REQUIRED)
find_package(TBB REQUIRED)
find_package(BLAS REQUIRED)
find_package(JPEG REQUIRED)
find_package(PNG REQUIRED)
find_package(liblzf REQUIRED)

# Add subdirectories
add_subdirectory(open3d)

# Make the library (target) name the project name
set(LIBRARY_NAME ${PROJECT_NAME})

if(BUILD_SHARED_LIBS)
    set(LIBRARY_TYPE SHARED)
else()
    set(LIBRARY_TYPE STATIC)
endif()

if(OPEN3D_IS_SUBDIRECTORY)
    # Must be PUBLIC if the library is added as a subdirectory in another project.
    set(LIBRARY_ACCESS PUBLIC)
else()
    # Must be PRIVATE to install and export the library
    set(LIBRARY_ACCESS PRIVATE)
endif()

# Add the library
add_library(${LIBRARY_NAME} ${LIBRARY_TYPE} ${Open3D_SOURCES})

# Set the library version
set_target_properties(${LIBRARY_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

if(BUILD_SHARED_LIBS)
    # Set .so major version so that libOpen3D.so.0 will be a symlink to libOpen3D.so.0.15.2
    set_target_properties(${LIBRARY_NAME} PROPERTIES SOVERSION 0)
endif()

# Set target include directories
target_include_directories(${LIBRARY_NAME} ${LIBRARY_ACCESS} ${Open3D_INCLUDE_DIRS})

# Set target link libraries
target_link_libraries(${LIBRARY_NAME} 
    PRIVATE
    # Standard library
    pthread
    stdc++fs
    # Apt packages
    fmt::fmt
    TBB::tbb
    BLAS::BLAS
    JPEG::JPEG
    PNG::PNG
    liblzf::liblzf
    lapacke
    # Built static libraries
    JsonCpp::JsonCpp
    Qhull::qhullcpp
    Qhull::qhullstatic_r
    # Built shared libraries
    PUBLIC
    Eigen3::Eigen
    assimp::assimp)

# Set target compile defintions (see Definitions.cmake)
target_compile_definitions(${LIBRARY_NAME} ${LIBRARY_ACCESS}
    # BLAS library (instead of MKL)
    USE_BLAS
    # Enable implementation for tinyobjloader
    TINYOBJLOADER_IMPLEMENTATION
    # Enable implementation for tinygltf
    TINYGLTF_IMPLEMENTATION STB_IMAGE_IMPLEMENTATION STB_IMAGE_WRITE_IMPLEMENTATION)

# Set target compile options (see Definitions.cmake)
target_compile_options(${LIBRARY_NAME} ${LIBRARY_ACCESS} ${OPEN3D_COMPILE_OPTIONS})

# Do not setup install/uninstall if the library is built as a subdirectory in another project
if(NOT OPEN3D_IS_SUBDIRECTORY)
    # Install and export
    include(cmake-minimal/Install.cmake)

    # Uninstall
    include(cmake-minimal/Uninstall.cmake)
endif()
