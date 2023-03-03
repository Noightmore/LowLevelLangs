cmake_minimum_required(VERSION 3.24)
project(sypaniNaVarku C)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -rdynamic -Wall")

set(CMAKE_C_STANDARD 23)

# include the gtk3 package

FIND_PACKAGE ( PkgConfig REQUIRED )
PKG_CHECK_MODULES( GTK REQUIRED gtk+-3.0 )
INCLUDE_DIRECTORIES ( ${GTK_INCLUDE_DIRS} )
SET ( FOOBAR_LIBS ${GTK_LIBRARIES} )

add_executable(sypaniNaVarku src/main.c src/include/gui_handler.h src/libs/gui_handler.c)
TARGET_LINK_LIBRARIES( sypaniNaVarku ${CMAKE_THREAD_LIBS_INIT} ${FOOBAR_LIBS} )

