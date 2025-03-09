/*
SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
SPDX-License-Identifier: MIT
*/

#include <iostream>
#include <cstring>
#include <sstream>
#include <set>
using namespace std;

#define INF 9999999

int main (int argc, char *argv[]) {

  int edgesCount = (argc-1) / 3;
  if(edgesCount == 0){
      return 1;
  }

  int* EDGES = new int[edgesCount*3];
  set<int> nodes;

  for(int i = 0; i < edgesCount; i++){
    for(int j = 0; j<3; j++){
        std::istringstream iss( argv[i*3+j+1] );
        int val;
        if (iss >> val){
            if(j<2) nodes.insert(val);
            EDGES[i*3+j] = val;
        }
    }
  }

  int G[nodes.size()][nodes.size()];
  memset(G, 0, sizeof(int) * nodes.size() * nodes.size());

  for(int t = 0; t < edgesCount; t++){
    int i = EDGES[t*3];
    int j = EDGES[t*3+1];
    int w = EDGES[t*3+2];
    G[i][j] = G[j][i] = w;
  }

  int no_edge;            // number of edge

  // create a array to track selected vertex
  // selected will become true otherwise false
  int selected[nodes.size()];

 // set selected false initially
  memset (selected, false, sizeof (selected));

 // set number of edge to 0
  no_edge = 0;

  // choose 0th vertex and make it true
  selected[0] = true;

  int x;            //  row number
  int y;            //  col number

  cout << "MST: ";
  while (no_edge < nodes.size() - 1) {

  //For every vertex in the set S, find the all adjacent vertices
  // , calculate the distance from the vertex selected at step 1.
  // if the vertex is already in the set S, discard it otherwise
  //choose another vertex nearest to selected vertex  at step 1.

      int min = INF;
      x = 0;
      y = 0;

      for (int i = 0; i < nodes.size(); i++) {
        if (selected[i]) {
            for (int j = 0; j < nodes.size(); j++) {
              if (!selected[j] && G[i][j]) { // not in selected and there is an edge
                  if (min > G[i][j]) {
                      min = G[i][j];
                      x = i;
                      y = j;
                  }

              }
          }
        }
      }
      cout << "(" << x << " " << y << " - " << G[x][y] << ") ";
      selected[y] = true;
      no_edge++;
    }

  return 0;
}
