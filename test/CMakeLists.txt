cmake_minimum_required(VERSION 3.10.0)

project(open3d-test)

# Set the path for Open3D dependencies
get_filename_component(DEPENDENCIES_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../dependencies/install ABSOLUTE)

set(ZLIB_INCLUDE_DIR ${DEPENDENCIES_PATH}/zlib)
set(ZLIB_LIBRARY ${DEPENDENCIES_PATH}/zlib/lib/libzlibstatic.a)

# Built static libraries
find_package(OpenMP REQUIRED)
find_package(jsoncpp REQUIRED PATHS ${DEPENDENCIES_PATH}/jsoncpp NO_DEFAULT_PATH)
find_package(Qhull REQUIRED PATHS ${DEPENDENCIES_PATH}/qhull NO_DEFAULT_PATH)
find_package(fmt REQUIRED PATHS ${DEPENDENCIES_PATH}/fmt NO_DEFAULT_PATH)
find_package(libjpeg-turbo REQUIRED PATHS ${DEPENDENCIES_PATH}/jpeg NO_DEFAULT_PATH)
find_package(PNG REQUIRED PATHS ${DEPENDENCIES_PATH}/png NO_DEFAULT_PATH)
find_package(TBB REQUIRED PATHS ${DEPENDENCIES_PATH}/tbb NO_DEFAULT_PATH)
find_package(OpenBLAS REQUIRED PATHS ${DEPENDENCIES_PATH}/openblas NO_DEFAULT_PATH)


# Find libpng
#find_package(PNG REQUIRED PATHS ${DEPENDENCIES_PATH}/png NO_DEFAULT_PATH)
find_package(assimp REQUIRED PATHS ${DEPENDENCIES_PATH}/assimp NO_DEFAULT_PATH)
find_package(Eigen3 REQUIRED PATHS ${DEPENDENCIES_PATH}/eigen NO_DEFAULT_PATH)
find_package(Open3D REQUIRED PATHS ${CMAKE_CURRENT_SOURCE_DIR}/../install NO_DEFAULT_PATH)

# Add executable target.
set(EXECUTABLE_NAME ${PROJECT_NAME})
add_executable(${EXECUTABLE_NAME} main.cpp)

target_include_directories(${EXECUTABLE_NAME} PUBLIC
    ${ZLIB_INCLUDE_DIR})

target_link_libraries(${EXECUTABLE_NAME}
    #PNG::PNG
    Open3D::Open3D
    ${ZLIB_LIBRARY})

# Use C++17 standard
set_target_properties(${EXECUTABLE_NAME} PROPERTIES 
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED True)

target_link_options(${EXECUTABLE_NAME} PUBLIC "-static")


