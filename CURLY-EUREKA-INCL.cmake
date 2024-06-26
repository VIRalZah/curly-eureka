﻿message("CURLY-EUREKA INCLUDED...\nCURLY_EUREKA_DIR - ${CMAKE_CURRENT_LIST_DIR}")
set(CURLY_EUREKA_DIR ${CMAKE_CURRENT_LIST_DIR})

#configure gdh game ver
if(DEFINED GAME_VERSION)
    message("NEW GAME_VERSION FOUND - ${GAME_VERSION}")
else()
    set(GAME_VERSION "2.1")
    message("GAME_VERSION ISN'T DEFINED, GAME_VERSION - ${GAME_VERSION}")
endif()

file(GLOB_RECURSE CURLY_EUREKA_SRC 
"${CURLY_EUREKA_DIR}/ce-main-src/*.cpp"
"${CURLY_EUREKA_DIR}/patterns/*.cpp"
)
message("CURLY_EUREKA_SRC: ${CURLY_EUREKA_SRC}")
    
set(CURLY_EUREKA_INCL
"${CURLY_EUREKA_DIR}"
"${CURLY_EUREKA_DIR}/ce-main-src"
"${CURLY_EUREKA_DIR}/patterns"
"${CURLY_EUREKA_DIR}/minhook-multihook/include"
"${CURLY_EUREKA_DIR}/gd.h_${GAME_VERSION}/"
"${CURLY_EUREKA_DIR}/gd.h_${GAME_VERSION}/include"
$IMGUI_HOOK_INCL
)
message("CURLY_EUREKA_INCL: ${CURLY_EUREKA_INCL}")

include_directories(${CURLY_EUREKA_INCL})

#EXCLUDE_MINHOOK?
if(DEFINED EXCLUDE_MINHOOK)
    message("FOUND EXCLUDE_MINHOOK DEFINTION, LIB WILL NOT INCLUDED")
else()
    message("EXCLUDE_MINHOOK ISN'T DEFINED, LIB WILL INCLUDED")
    add_subdirectory("${CURLY_EUREKA_DIR}/minhook-multihook" minhook-build)
    link_libraries(minhook)
endif()

#EXCLUDE_COCOS_HEADERS?
if(DEFINED EXCLUDE_COCOS_HEADERS)
    message("FOUND EXCLUDE_COCOS_HEADERS DEFINTION, LIB WILL NOT INCLUDED")
else()
    message("EXCLUDE_COCOS_HEADERS ISN'T DEFINED, LIB WILL INCLUDED")
    add_subdirectory("${CURLY_EUREKA_DIR}/cocos-headers_${GAME_VERSION}" cocos-headers-build)
    link_libraries(cocos2d)
endif()