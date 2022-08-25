add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/camera)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/geometry)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/io)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/pipelines)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/utility)

set(open3d_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/Open3DConfig.cpp
    ${camera_SOURCES}
    ${core_SOURCES}
    ${geometry_SOURCES}
    ${io_SOURCES}
    ${pipelines_SOURCES}
    ${utility_SOURCES}
    PARENT_SCOPE)
