cmake_minimum_required(VERSION 3.16.0)

# Check operating system.  Only Linux is supported 
if (NOT ${CMAKE_SYSTEM_NAME} STREQUAL Linux)
    message(FATAL_ERROR "Operating system ${CMAKE_SYSTEM_NAME} is not supported.")
endif()

project(Open3D VERSION 0.15.2 DESCRIPTION "Open3D Library.")

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Build options
option(BUILD_SHARED_LIBS "Build Open3D as a shared library." ON)
option(OPEN3D_IS_SUBDIRECTORY "Build Open3D as a subdirectory in another project." OFF)

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

# Set the path for Open3D depencencies
set(OPEN3D_DEPENDENCIES_PATH ${CMAKE_CURRENT_SOURCE_DIR}/dependencies/install)

# Check if the dependencies path exists.
# If it does not exist, run 'scripts/build-dependencies' before running cmake.
get_filename_component(_fullpath "${_dir}" REALPATH)
if (NOT EXISTS "${OPEN3D_DEPENDENCIES_PATH}")
    message(FATAL_ERROR "The Open3D dependencies path [${OPEN3D_DEPENDENCIES_PATH}] does not exist.  Run 'scripts/build-dependencies' to build the dependencies and run cmake again.")
endif()


# Find dependency packages

# Built shared libraries
find_package(assimp 5.1 REQUIRED PATHS ${OPEN3D_DEPENDENCIES_PATH}/assimp NO_DEFAULT_PATH)
find_package(Eigen3 3.4 REQUIRED PATHS ${OPEN3D_DEPENDENCIES_PATH}/eigen NO_DEFAULT_PATH)

# Built static libraries
find_package(jsoncpp 1.5 REQUIRED PATHS ${OPEN3D_DEPENDENCIES_PATH}/jsoncpp NO_DEFAULT_PATH)
find_package(Qhull 8.0 REQUIRED PATHS ${OPEN3D_DEPENDENCIES_PATH}/qhull NO_DEFAULT_PATH)

# Apt packages
# If any of these packages do not exist, run 'scripts/install-required-packages' before running cmake.
find_package(fmt REQUIRED)
find_package(TBB REQUIRED)
find_package(JPEG REQUIRED)
find_package(PNG REQUIRED)
find_package(liblzf REQUIRED)
find_package(BLAS REQUIRED)

# Add subdirectories
add_subdirectory(cpp/open3d)
add_subdirectory(submodules)
add_subdirectory(3rdparty)

# Add the library
set(LIBRARY_NAME ${PROJECT_NAME})
add_library(${LIBRARY_NAME} ${LIBRARY_TYPE}
    ${open3d_SOURCES}
    ${3rdparty_SOURCES})

# Set target include directories
target_include_directories(${LIBRARY_NAME} ${LIBRARY_ACCESS} 
    ${CMAKE_CURRENT_SOURCE_DIR}/cpp
    ${CMAKE_CURRENT_BINARY_DIR}/cpp
    ${submodules_INCLUDE_DIRS}
    ${3rdparty_INCLUDE_DIRS})

# Set target link libraries
target_link_libraries(${LIBRARY_NAME} 
    PRIVATE
    # Standard library
    pthread
    stdc++fs
    # Apt packages
    fmt::fmt
    TBB::tbb
    JPEG::JPEG
    PNG::PNG
    liblzf::liblzf
    openblas
    lapacke
    
    # Built static libraries
    JsonCpp::JsonCpp
    Qhull::qhullcpp
    Qhull::qhullstatic_r
    # Built shared libraries
    PUBLIC
    assimp::assimp
    Eigen3::Eigen)

# Set target compile defintions
target_compile_definitions(${LIBRARY_NAME} ${LIBRARY_ACCESS}
    # BLAS library (instead of MKL)
    USE_BLAS
    # Enable implementation for tinyobjloader
    TINYOBJLOADER_IMPLEMENTATION
    # Enable implementation for tinygltf
    TINYGLTF_IMPLEMENTATION STB_IMAGE_IMPLEMENTATION STB_IMAGE_WRITE_IMPLEMENTATION)

# Set target compile options
set(OPEN3D_COMPILE_OPTIONS)

if (${CMAKE_SYSTEM_PROCESSOR} STREQUAL armv7l)
     # Additional compiler options for armv7l
     list(APPEND OPEN3D_COMPILE_OPTIONS -Wno-psabi -mcpu=cortex-a72 -mfpu=neon-vfpv4)
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL aarch64)
     # Additional compiler options for aarch64
     list(APPEND OPEN3D_COMPILE_OPTIONS -Wno-psabi)
endif()

target_compile_options(${LIBRARY_NAME} ${LIBRARY_ACCESS} ${OPEN3D_COMPILE_OPTIONS})

# Set the library version
set_target_properties(${LIBRARY_NAME} PROPERTIES VERSION ${PROJECT_VERSION})

if(BUILD_SHARED_LIBS)
    # Set .so major version so that libOpen3D.so.0 will be a symlink to libOpen3D.so.0.15.2
    set_target_properties(${LIBRARY_NAME} PROPERTIES SOVERSION ${PROJECT_VERSION_MAJOR})
endif()

# Configure the top-level header files
configure_file(${open3d_SOURCE_DIR}/Open3D.h.in ${open3d_BINARY_DIR}/Open3D.h)
configure_file(${open3d_SOURCE_DIR}/Open3DConfig.h.in ${open3d_BINARY_DIR}/Open3DConfig.h)

# Do not setup install/uninstall if the library is built as a subdirectory in another project
if(NOT OPEN3D_IS_SUBDIRECTORY)
    # Install and export
    include(cmake/Install.cmake)

    # Uninstall
    include(cmake/Uninstall.cmake)
endif()