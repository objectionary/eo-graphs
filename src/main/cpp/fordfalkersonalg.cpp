#include <iostream>
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

int main() {
    fill(firstEdge, firstEdge + MAX_V, -1);    
    cin >> numOfVertex >> numOfEdge;            
    cin >> sourceVertex >> destinationVertex;  
    for (int i = 0, u, v, cap; i < numOfEdge; i++) {
        cin >> u >> v >> cap;
        addEdge(u, v, cap);
    }
  
    int maxFlow = 0;
    int iterationResult = 0;
    while ((iterationResult = findFlow(sourceVertex, INF)) > 0) {
        fill(visited, visited + MAX_V, false);
        maxFlow += iterationResult;
    }
  
    cout << maxFlow << endl;
    return 0;
}
