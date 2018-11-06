//
// Created by kraftwerk28 on 24.10.18.
//

#ifndef TEST1_GRAPH_SOLVER_H
#define TEST1_GRAPH_SOLVER_H

#include <initializer_list>
#include <vector>
#include <iostream>

typedef std::initializer_list<int> int_list;
typedef std::initializer_list<std::initializer_list<int>> grid;
typedef unsigned int uint;

class graph_solver
{
public:
    graph_solver(std::initializer_list<std::initializer_list<int>> matrix)
        : data(matrix) {}

    virtual ~graph_solver() = default;

public:
    std::initializer_list<std::initializer_list<int>> data;

    virtual std::vector<int> find(uint start_index) = 0;
};

// DFS

class dfs_solver : public graph_solver
{
public:
    dfs_solver(std::initializer_list<std::initializer_list<int>> matrix)
        : graph_solver(matrix) {}

    std::vector<int> find(uint start_index) final;

private:

    void bfs(uint index, int **edges, std::vector<int> &stack, int start_index);
};

// BFS

class bfs_solver : public graph_solver
{
public:
    bfs_solver(std::initializer_list<std::initializer_list<int>> matrix)
        : graph_solver(matrix) {}

    std::vector<int> find(uint start_index) final;

private:
    void bfs(uint index, int **edges, std::vector<int> &stack);
};


#endif //TEST1_GRAPH_SOLVER_H
