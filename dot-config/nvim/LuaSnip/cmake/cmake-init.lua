local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").re

return {
    s({trig="<startup", dscr="a template for cmake startup"},
        fmta(
            [[
                cmake_minimum_required(VERSION <>)

                set(CMAKE_CXX_COMPILER "/usr/bin/g++" CACHE FILEPATH "C++ Compiler" FORCE)
                set(CMAKE_C_COMPILER "/usr/bin/gcc" CACHE FILEPATH "C Compiler" FORCE)
                set(CMAKE_CXX_STANDARD <>)
                set(CMAKE_CXX_STANDARD_REQUIRED ON)
                set(CMAKE_CXX_EXTENSIONS ON)
                set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


                project(<> VERSION <> LANGUAGES <>)
                include(GNUInstallDirs)
                # include(CMakePackageConfigHelpers)


                if (NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
                  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Choose the type of build." FORCE)
                endif()
                set_property(CACHE CMAKE_BUILD_TYPE PROPERTY
                    STRINGS Debug Release RelWithDebInfo MiniSizeRel)
                message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
                cmake_host_system_information(RESULT CPU_NUMS QUERY NUMBER_OF_LOGICAL_CORES)
                message(STATUS "CPU NUMS on current server is: ${CPU_NUMS}")
                math(EXPR JOBS "${CPU_NUMS} + ${CPU_NUMS} / 2")
                set(CMAKE_BUILD_PARALLEL_LEVEL ${JOBS} CACHE STRING "并行编译线程数")
                message(STATUS "Compiler default work jobs: ${CMAKE_BUILD_PARALLEL_LEVEL}")
            ]],
            {
                i(1, "3.25...3.51"),
                i(2, "20"),
                i(3, "project_name"),
                i(4, "version"),
                i(5, "CXX"),
            }
        )
    ),
}
