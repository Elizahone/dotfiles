local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s({trig="<options", dscr="a template for cmake options"},
        fmt(
            [[
                if (NOT TARGET {})
                    add_library({} INTERFACE)
                    target_compile_options({} INTERFACE
                      # GCC/Clang 通用选项
                      $<$<OR:$<CXX_COMPILER_ID:GNU>,$<CXX_COMPILER_ID:Clang>>:
                        -Wall
                        -Wextra
                        -Wpedantic
                        -fno-strict-aliasing
                      >
                    )

                    target_compile_options({} INTERFACE
                      $<$<AND:$<PLATFORM_ID:LINUX>,$<OR:$<PLATFORM_ID:GNU>,$<PLATFORM_ID:Clang>>>:
                        -fPIC
                      >
                    )

                    target_link_options({} INTERFACE
                      $<$<AND:$<PLATFORM_ID:LINUX>,$<OR:$<PLATFORM_ID:GNU>,$<PLATFORM_ID:Clang>>>:
                        -rdynamic
                      >
                    )


                    target_compile_options({} INTERFACE
                      $<$<CONFIG:Debug>:
                        -O0
                        -g3
                        -ggdb
                      >
                    )

                    target_compile_options({} INTERFACE
                      $<$<CONFIG:Release>:
                        -DNDEBUG
                        -O2
                        -fno-omit-frame-pointer
                      >
                      $<$<CONFIG:RelWithDebInfo>:
                        -DNDEBUG
                        -O2
                        -g
                        -fno-omit-frame-pointer
                      >
                    )

                    option(ENABLE_COVERAGE "Enable code coverage instrumentation" OFF)
                    if(ENABLE_COVERAGE)
                      target_compile_options({} INTERFACE
                        $<$<CONFIG:Debug>:--coverage>
                      )
                      target_link_options({} INTERFACE
                        $<$<CONFIG:Debug>:--coverage>
                      )
                    endif()
                endif()
            ]],
            {
                rep(1),
                i(1, "interface_name"),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
                rep(1),
            },
            { delimiters = "{}" }
        )
    ),
}
