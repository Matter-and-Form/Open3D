# Set install directories
include(GNUInstallDirs)

set(LIBRARY_CMAKE_DIR ${CMAKE_INSTALL_LIBDIR}/${LIBRARY_NAME}/cmake)
set(LIBRARY_INCLUDE_DIR ${CMAKE_INSTALL_INCLUDEDIR})
set(LIBRARY_LIBRARY_DIR ${CMAKE_INSTALL_LIBDIR})
set(LIBRARY_RUNTIME_DIR ${CMAKE_INSTALL_BINDIR})
#set(LIBRARY_DOC_DIR ${CMAKE_INSTALL_DOCDIR})

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
    $<INSTALL_INTERFACE:${LIBRARY_INCLUDE_DIR}>
)

# Install library binaries
install(TARGETS ${LIBRARY_NAME}
    EXPORT ${LIBRARY_NAME}Targets
    LIBRARY DESTINATION ${LIBRARY_LIBRARY_DIR}
    RUNTIME DESTINATION ${LIBRARY_RUNTIME_DIR}
)

# Install CMake config files
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}Config.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/${LIBRARY_NAME}ConfigVersion.cmake
    DESTINATION ${LIBRARY_CMAKE_DIR})

install(EXPORT ${LIBRARY_NAME}Targets
   NAMESPACE ${LIBRARY_NAME}::
   DESTINATION ${LIBRARY_CMAKE_DIR})

# Install public API

# Install the top-level header files
install(FILES 
    ${open3d_BINARY_DIR}/Open3D.h 
    ${open3d_BINARY_DIR}/Open3DConfig.h
    ${open3d_SOURCE_DIR}/Macro.h
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d)

# Install all header files in cpp/open3d/camera
install(DIRECTORY ${open3d_SOURCE_DIR}/camera
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install all header files in cpp/open3d/core
install(DIRECTORY ${open3d_SOURCE_DIR}/core
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install all header files in cpp/open3d/geometry
install(DIRECTORY ${open3d_SOURCE_DIR}/geometry
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install all header files in cpp/open3d/io
install(DIRECTORY ${open3d_SOURCE_DIR}/io
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install all header files in cpp/open3d/pipelines
install(DIRECTORY ${open3d_SOURCE_DIR}/pipelines
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install all header files in cpp/open3d/utility
install(DIRECTORY ${open3d_SOURCE_DIR}/utility
    DESTINATION ${LIBRARY_INCLUDE_DIR}/open3d
    FILES_MATCHING PATTERN "*.h")

# Install licence file
#install(FILES LICENSE DESTINATION ${LIBRARY_DOC_DIR})
