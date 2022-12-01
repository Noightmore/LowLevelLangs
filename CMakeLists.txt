cmake_minimum_required(VERSION 3.23)
project(PolotovarFactory)

set(CMAKE_CXX_STANDARD 23)

add_executable(PolotovarFactory main.cpp HeaderFiles/Polotovar.h Model/Polotovar.cpp)
