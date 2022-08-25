set(3rdparty_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/liblzf/liblzf/lzf_c.c
    ${CMAKE_CURRENT_SOURCE_DIR}/liblzf/liblzf/lzf_d.c
    ${CMAKE_CURRENT_SOURCE_DIR}/rply/rply/rply.c
    PARENT_SCOPE)

set(3rdparty_INCLUDE_DIRS
    ${CMAKE_CURRENT_SOURCE_DIR}/liblzf
    ${CMAKE_CURRENT_SOURCE_DIR}/rply/rply
    ${CMAKE_CURRENT_SOURCE_DIR}/tomasakeninemoeller/include
	PARENT_SCOPE)