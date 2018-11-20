cmake_minimum_required(VERSION 3.12)
project(test1)

set(CMAKE_CXX_STANDARD 14)

add_executable(test1 main.cc graph_solver.cc graph_solver.h)