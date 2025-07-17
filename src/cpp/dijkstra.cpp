// SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
// SPDX-License-Identifier: MIT

#include <iostream>
#include <climits>
#include <cstring>
#include <stdlib.h>
using namespace std;

void dijkstra(int vNum, int* GR, int st)
{
    int distance[vNum], count, index, i, u, m=st, path[vNum];
    bool visited[vNum];
    for (i=0; i<vNum; i++){
        distance[i]=INT_MAX; visited[i]=false;
        path[i]=-1;
    }
    path[st]=st;
    distance[st]=0;
    for (count=0; count<vNum-1; count++){
        int min=INT_MAX;
        for (i=0; i<vNum; i++)
            if (!visited[i] && distance[i]<=min){
                min=distance[i]; index=i;
            }
        u=index;
        visited[u]=true;
        for (i=0; i<vNum; i++)
            if (!visited[i] && GR[u*vNum+i] && distance[u]!=INT_MAX &&
            distance[u]+GR[u*vNum+i]<distance[i]){
                distance[i]=distance[u]+GR[u*vNum+i];
                path[i]=u;
            }

    }
    cout << "Paths: ";
    for (i=0; i<vNum; i++)
      cout << path[i] << " ";
}

int main(int argc, char* argv[]) {
  if (argc > 1) {
    int i = 2;
    int vNum = stoi(argv[1]);
    int* GR = new int[vNum * vNum];
    memset(GR, 0, sizeof(GR));
    while (i < argc) {
      int number_of_edges = stoi(argv[i]);
      int u = stoi(argv[i + 1]);
      i += 2;
      for (int j = 0; j < number_of_edges; ++j) {
        int v, w;
        sscanf(argv[i + j], "%d:%d", &v, &w);
        GR[u * vNum + v] = w;
      }
      i += number_of_edges;
    }
    dijkstra(vNum, GR, 0);
    delete[] GR;
  }

  return 0;
}
