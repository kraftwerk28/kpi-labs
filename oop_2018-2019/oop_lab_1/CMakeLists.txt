cmake_minimum_required(VERSION 3.12)
project(oop_lab_1)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(oop_lab_1
        dice_game.cc
        dice_game.h
        main.cc
        Makefile
        sfml.cpp)
