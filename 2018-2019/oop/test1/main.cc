#include <iostream>
#include "graph_solver.h"

int main()
{
    graph_solver *gs1 = new dfs_solver({
                                          {0, 1, 1, 0},
                                          {1, 0, 1, 1},
                                          {1, 1, 0, 0},
                                          {0, 1, 0, 0}
                                      });

    graph_solver *gs2 = new bfs_solver({
                                          {0, 1, 1, 0},
                                          {1, 0, 1, 1},
                                          {1, 1, 0, 0},
                                          {0, 1, 0, 0}
                                      });

    gs1->find(2);
//    gs2->find(1);


    delete gs1;
    delete gs2;

    return 0;

}