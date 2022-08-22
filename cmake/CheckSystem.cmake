# Check operating system
if (${CMAKE_SYSTEM_NAME} STREQUAL Linux)
    # Linux
else()
    message(FATAL_ERROR "Operating system ${CMAKE_SYSTEM_NAME} is not supported.")
endif()

execute_process(COMMAND grep -q ubuntu /etc/os-release RESULT_VARIABLE IS_UBUNTU)
execute_process(COMMAND grep -q buster /etc/os-release RESULT_VARIABLE IS_BUSTER)
execute_process(COMMAND grep -q bullseye /etc/os-release RESULT_VARIABLE IS_BULLSEYE)

# Check operating system version
if (${IS_UBUNTU} EQUAL 0)
    # Ubuntu OS.  Check version
    execute_process(COMMAND grep -oP VERSION_ID="\\K[^"]+ /etc/os-release OUTPUT_VARIABLE UBUNTU_VERSION)
    if (${UBUNTU_VERSION} EQUAL 20.04)
        # Ubuntu 20.04 (Focal Fossa)
        set(OS_NAME ubuntu-20.04)
    else()
        message(FATAL_ERROR "Ubuntu version ${UBUNTU_VERSION} is not supported.")
    endif()
elseif (${IS_BUSTER} EQUAL 0)
    # Raspian 10 (Buster)
    set(OS_NAME raspbian-10)
elseif (${IS_BULLSEYE} EQUAL 0)
    # Raspian 11 (Bullseye)
    set(OS_NAME raspbian-11)
else()
    message(FATAL_ERROR "Operating system version is not supported.")
endif()

# Check system architecture
if (${CMAKE_SYSTEM_PROCESSOR} STREQUAL armv7l)
    # ARM 32-bit
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL aarch64)
    # ARM 64-bit
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL x86_64)
    # x86_64
else()
    message(FATAL_ERROR "Architecture ${CMAKE_SYSTEM_PROCESSOR} is not supported.")
endif()