cmake_minimum_required(VERSION 3.24)
project(Fonty)

set(CMAKE_CXX_STANDARD 17)

add_executable(Fonty main.cpp Models/TextBlock.h Models/TextBlock.cpp Models/ColorSetter.h Models/FontSetter.h Models/SetRedColor.h Models/SetRedColor.cpp Models/Substring.h Models/Substring.cpp)
