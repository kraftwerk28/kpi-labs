cmake_minimum_required(VERSION 3.12)
project(oop_lab_2)

set(CMAKE_CXX_STANDARD 14)

add_executable(oop_lab_2 main.cc matrix.cc matrix.h frobenius.h krylov_method.h danilevskyi_method.h)
target_link_libraries(oop_lab_2 -lpthread)
