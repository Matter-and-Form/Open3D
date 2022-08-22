# Set install directories
include(GNUInstallDirs)

set(LIBRARY_CMAKE_DIR ${CMAKE_INSTALL_LIBDIR}/${LIBRARY_NAME}/cmake)
set(LIBRARY_INCLUDE_DIR ${CMAKE_INSTALL_INCLUDEDIR})
set(LIBRARY_LIBRARY_DIR ${CMAKE_INSTALL_LIBDIR})
set(LIBRARY_RUNTIME_DIR ${CMAKE_INSTALL_BINDIR})
#set(LIBRARY_DOC_DIR ${CMAKE_INSTALL_DOCDIR})
#set(LIBRARY_PKGCONFIG_DIR ${CMAKE_INSTALL_LIBDIR}/pkgconfig)

# For dependencies to link automatically in projects importing this library,
# we either need to set the flag -DCMAKE_INSTALL_RPATH='$ORIGIN' when calling
# cmake or we need to set the property here.
set_target_properties(${LIBRARY_NAME} PROPERTIES INSTALL_RPATH "$ORIGIN")

# Create CMake config files
include(CMakePackageConfigHelpers)

configure_package_config_file(
    ${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in
    ${LIBRARY_NAME}Config.cmake
    INSTALL_DESTINATION ${LIBRARY_CMAKE_DIR}
    PATH_VARS LIBRARY_INCLUDE_DIR LIBRARY_LIBRARY_DIR
    NO_CHECK_REQUIRED_COMPONENTS_MACRO)

write_basic_package_version_file(
    ${LIBRARY_NAME}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion)

# Set install include directories
target_include_directories(${LIBRARY_NAME} INTERFACE
    #$<BUILD_INTERFACE:${Open3D_INCLUDE_DIRS}>
    $<INSTALL_INTERFACE:${LIBRARY_INCLUDE_DIR}>
)

# Install library binaries
install(TARGETS ${LIBRARY_NAME}
    EXPORT ${LIBRARY_NAME}Targets
    LIBRARY DESTINATION ${LIBRARY_LIBRARY_DIR}
    RUNTIME DESTINATION ${LIBRARY_RUNTIME_DIR}
    #PUBLIC_HEADER DESTINATION ${LIBRARY_INCLUDE_DIR}
)

# Install CMake config files
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}ConfigVersion.cmake
    DESTINATION ${LIBRARY_CMAKE_DIR})

install(EXPORT ${LIBRARY_NAME}Targets
   NAMESPACE ${LIBRARY_NAME}::
   DESTINATION ${LIBRARY_CMAKE_DIR})

# This seems to have no effect
# export(TARGETS ${LIBRARY_NAME} FILE ${LIBRARY_NAME}Targets.cmake)

# Install public API

# Option 1: There is a single pulbic header
#set_target_properties(${LIBRARY_NAME} PROPERTIES PUBLIC_HEADER source/Open3D.hpp)

# Option 2: Install files explicitly
#install(FILES source/Open3D.hpp ${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}Version.hpp DESTINATION ${LIBRARY_INCLUDE_DIR})
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/open3d/Macro.h DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d)

# Option 3: Install all header files in the source directory
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/open3d/camera
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/open3d/core
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/open3d/geometry
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/open3d/io
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/open3d/pipelines
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/open3d/utility
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install licence file
#install(FILES LICENSE DESTINATION ${LIBRARY_DOC_DIR})

# Install pkg-config file
#install(FILES "${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}.pc" DESTINATION ${LIBRARY_PKGCONFIG_DIR})