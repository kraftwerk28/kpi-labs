//
// Created by kraftwerk28 on 24.10.18.
//

#include "graph_solver.h"

std::vector<int> dfs_solver::find(uint start_index)
{
    std::vector<int> stack;

    int **edges = new int *[data.size()];
    for (uint i = 0; i < data.size(); i++)
    {
        edges[i] = new int[data.size()];
        for (uint j = 0; j < data.size(); j++)
        {
            edges[i][j] = *((data.begin() + i)->begin() + j);
        }
    }

    stack.push_back(start_index);
    std::cout << start_index << std::endl;
    bfs(start_index, edges, stack, start_index);

    return stack;
}

void dfs_solver::bfs(uint index, int **edges, std::vector<int> &stack,
                     int start_index)
{
    int_list vert = *(data.begin() + index);

    std::cout << "---------------\n";
    for (uint i = 0; i < vert.size(); i++)
    {
        if (edges[index][i] > 0)
        {
            edges[index][i]--;
            stack.push_back(i);
            std::cout << "edge: " << i << "\n";
            for (int i = 0; i < stack.size(); i++)
            {
                std::cout << *(stack.begin() + i) << " ";
            }
            std::cout << "\n";
            bfs(i, edges, stack, start_index);
            return;
        }
    }
    stack.pop_back();
    uint last = (uint) *(stack.end());
    std::cout << "Last in stack: " << last << std::endl;


    std::cout << "\n";
    if (last == start_index)
        return;
    else
        bfs(last, edges, stack, start_index);
}


std::vector<int> bfs_solver::find(uint start_index)
{
    std::vector<int> stack;

    int **edges = new int *[data.size()];
    for (uint i = 0; i < data.size(); i++)
    {
        edges[i] = new int[data.size()];
        for (uint j = 0; j < data.size(); j++)
        {
            edges[i][j] = *((data.begin() + i)->begin() + j);
        }
    }

    stack.push_back(start_index);
    std::cout << start_index << std::endl;
    bfs(start_index, edges, stack);

    return stack;


    return std::vector<int>();
}

void bfs_solver::bfs(uint index, int **edges, std::vector<int> &stack)
{
    int_list vert = *(data.begin() + index);
    for (uint i = 0; i < vert.size(); i++)
    {
        if (edges[index][i] > 0)
        {
            edges[index][i]--;
            stack.push_back(i);
            std::cout << "edge: " << i << "\n";
            for (int i = 0; i < stack.size(); i++)
            {
                std::cout << *(stack.begin() + i) << " ";
            }
            std::cout << "\n";
            return;
        }
    }
    std::vector<int> stack2;
    for (int i = 1; i < stack.size(); i++)
    {
        stack2.push_back(*(stack.begin() + i));
        std::cout << *(stack.begin() + i);
    }
    std::cout << "\n";
    bfs((uint) *(stack.begin()), edges, stack);
}
