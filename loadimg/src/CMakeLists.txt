cmake_minimum_required(VERSION 3.10)
project(loadimg C)

set(CMAKE_C_STANDARD 99)

if(MSVC)
    add_compile_options(/W3)
else()
    add_compile_options(-Wall -Wextra -Wno-unused-parameter)
endif()

add_executable(loadimg loadimg.c)

if(UNIX)
    target_link_libraries(loadimg m)
endif()

install(TARGETS loadimg DESTINATION bin)
