cmake_minimum_required(VERSION 3.24)
project(banka_v1)

set(CMAKE_CXX_STANDARD 23)

add_executable(banka_v1 src/main.cpp src/models/user_account.cpp src/models/headers/user_account.h src/models/currency.cpp src/models/headers/currency.h src/models/bank.cpp src/models/headers/bank.h src/services/site_functionality.h src/services/business_logic.cpp src/services/business_logic.h)
