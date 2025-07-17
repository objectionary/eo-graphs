// SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
// SPDX-License-Identifier: MIT

#include <iostream>
#include <climits>
#include <cstring>
#include <stdlib.h>
using namespace std;

const int MAX_E = (int) 1e6;
const int MAX_V = (int) 1e3;
const int INF   = (int) 1e9;

int numOfVertex, numOfEdge, sourceVertex, destinationVertex;
int capacity[MAX_E], onEnd[MAX_E], nextEdge[MAX_E], edgeCount;
int firstEdge[MAX_V], visited[MAX_V];

void addEdge(int u, int v, int cap) {
    onEnd[edgeCount] = v;
    nextEdge[edgeCount] = firstEdge[u];
    firstEdge[u] = edgeCount;
    capacity[edgeCount++] = cap;
    onEnd[edgeCount] = u;
    nextEdge[edgeCount] = firstEdge[v];
    firstEdge[v] = edgeCount;
    capacity[edgeCount++] = 0;
}

int findFlow(int u, int flow) {
    if (u == destinationVertex) return flow;
    visited[u] = true;
    for (int edge = firstEdge[u]; edge != -1; edge = nextEdge[edge]) {
        int to = onEnd[edge];
        if (!visited[to] && capacity[edge] > 0) {
            int minResult = findFlow(to, min(flow, capacity[edge]));
            if (minResult > 0) {
                capacity[edge]      -= minResult;
                capacity[edge ^ 1]  += minResult;
                return minResult;
            }
        }
    }
    return 0;
}

int main(int argc, char *argv[]) {
  if (argc > 1) {
    fill(firstEdge, firstEdge + MAX_V, -1);

    int i = 1;
    int vNum = stoi(argv[i]);
    ++i;
    numOfVertex = vNum;
    sourceVertex = 0;
    destinationVertex = numOfVertex - 1;
    while (i < argc) {
      int eNum = stoi(argv[i]);
      int u = stoi(argv[i + 1]);
      i += 2;
      for (int j = 0; j < eNum; ++j) {
        int v, w;
        sscanf(argv[i + j], "%d:%d", &v, &w);
        addEdge(u, v, w);
      }
      i += eNum;
    }
    int maxFlow = 0;
    int iterationResult = 0;
    while ((iterationResult = findFlow(sourceVertex, INF)) > 0) {
      fill(visited, visited + MAX_V, false);
      maxFlow += iterationResult;
    }

    cout << maxFlow << "\n";
  }
  return 0;
}
