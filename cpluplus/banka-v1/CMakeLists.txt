cmake_minimum_required(VERSION 3.24)
project(banka_v1)

set(CMAKE_CXX_STANDARD 23)

add_executable(
        banka_v1
        src/main.cpp
        src/models/UserAccount.cpp
        src/models/headers/UserAccount.h
        src/models/Currency.cpp
        src/models/headers/Currency.h
        src/models/Bank.cpp
        src/models/headers/Bank.h
        src/services/SiteFunctionality.h
        src/services/BusinessLogic.cpp
        src/services/BusinessLogic.h
        src/pages/PageGenerator.cpp
        src/pages/PageGenerator.h src/models/ExchangeRates.cpp src/models/headers/ExchangeRates.h)
