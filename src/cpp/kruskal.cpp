// SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
// SPDX-License-Identifier: MIT

#include <iostream>
#include <set>
#include <vector>
#include <algorithm>
#include <string>
#include <string.h>
#include <sstream>
using namespace std;

class Edge {
public:
	int src, dest, weight;
};

class Graph {
public:

	int V, E;

	Edge* edge;
};

Graph* createGraph(int V, int E)
{
	Graph* graph = new Graph;
	graph->V = V;
	graph->E = E;

	graph->edge = new Edge[E];

	return graph;
}

class subset {
public:
	int parent;
	int rank;
};

int find(subset subsets[], int i){
	if (subsets[i].parent != i)
		subsets[i].parent
			= find(subsets, subsets[i].parent);

	return subsets[i].parent;
}

void Union(subset subsets[], int x, int y)
{
	int xroot = find(subsets, x);
	int yroot = find(subsets, y);

	if (subsets[xroot].rank < subsets[yroot].rank)
		subsets[xroot].parent = yroot;
	else if (subsets[xroot].rank > subsets[yroot].rank)
		subsets[yroot].parent = xroot;
	else {
		subsets[yroot].parent = xroot;
		subsets[xroot].rank++;
	}
}

int myComp(const void* a, const void* b)
{
	Edge* a1 = (Edge*)a;
	Edge* b1 = (Edge*)b;
	return a1->weight > b1->weight;
}

void KruskalMST(Graph* graph){
	int V = graph->V;
	Edge result[V];
	int e = 0;
	int i = 0;

	qsort(graph->edge, graph->E, sizeof(graph->edge[0]),
		myComp);

	subset* subsets = new subset[(V * sizeof(subset))];

	for (int v = 0; v < V; ++v)
	{
		subsets[v].parent = v;
		subsets[v].rank = 0;
	}
	while (e < V - 1 && i < graph->E){
		Edge next_edge = graph->edge[i++];

		int x = find(subsets, next_edge.src);
		int y = find(subsets, next_edge.dest);


		if (x != y) {
			result[e++] = next_edge;
			Union(subsets, x, y);
		}
	}

	cout << "MST: ";
	for (i = 0; i < e; ++i)
	{
		cout << "(" << result[i].src << " " << result[i].dest
			<< " - " << result[i].weight << ") ";
	}
}

int main(int argc, char *argv[]){
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

	Graph* graph = createGraph(nodes.size(), edgesCount);

	for(int t = 0; t < edgesCount; t++){
        graph->edge[t].src = EDGES[t*3];
        graph->edge[t].dest = EDGES[t*3+1];
        graph->edge[t].weight = EDGES[t*3+2];
    }

	KruskalMST(graph);

	return 0;
}
