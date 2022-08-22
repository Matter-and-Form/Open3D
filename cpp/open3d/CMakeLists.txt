add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/camera ${CMAKE_BINARY_DIR}/camera)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/core ${CMAKE_BINARY_DIR}/core)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/geometry ${CMAKE_BINARY_DIR}/geometry)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/io ${CMAKE_BINARY_DIR}/io)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/pipelines ${CMAKE_BINARY_DIR}/pipelines)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/utility ${CMAKE_BINARY_DIR}/utility)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty ${CMAKE_BINARY_DIR}/3rdparty)

set(Open3D_SOURCES
    ${camera_SOURCES}
    ${core_SOURCES}
    ${geometry_SOURCES}
    ${io_SOURCES}
    ${pipelines_SOURCES}
    ${utility_SOURCES}
    ${3rdparty_SOURCES}
    PARENT_SCOPE)

set(Open3D_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/..
    ${3rdparty_INCLUDE_DIRS}
	PARENT_SCOPE)
