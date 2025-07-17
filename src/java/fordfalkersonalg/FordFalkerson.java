/**
 * SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
 * SPDX-License-Identifier: MIT
 */
import java.lang.*;
import java.util.Arrays;
import java.util.LinkedList;

class FordFalkerson {

    /* Returns true if there is a path from source 's' to
      sink 't' in residual graph. Also fills parent[] to
      store the path */
    boolean bfs(int rGraph[][], int s, int t, int parent[])
    {
        final int V = rGraph.length;
        // Create a visited array and mark all vertices as
        // not visited
        boolean visited[] = new boolean[V];
        for (int i = 0; i < V; ++i)
            visited[i] = false;

        // Create a queue, enqueue source vertex and mark
        // source vertex as visited
        LinkedList<Integer> queue
            = new LinkedList<Integer>();
        queue.add(s);
        visited[s] = true;
        parent[s] = -1;

        // Standard BFS Loop
        while (queue.size() != 0) {
            int u = queue.poll();

            for (int v = 0; v < V; v++) {
                if (visited[v] == false
                    && rGraph[u][v] > 0) {
                    // If we find a connection to the sink
                    // node, then there is no point in BFS
                    // anymore We just have to set its parent
                    // and can return true
                    if (v == t) {
                        parent[v] = u;
                        return true;
                    }
                    queue.add(v);
                    parent[v] = u;
                    visited[v] = true;
                }
            }
        }

        // We didn't reach sink in BFS starting from source,
        // so return false
        return false;
    }

    // Returns the maximum flow from s to t in the given
    // graph
    int fordFulkerson(int graph[][], int s, int t)
    {
        int u, v;

        final int V = graph.length;

        // Create a residual graph and fill the residual
        // graph with given capacities in the original graph
        // as residual capacities in residual graph

        // Residual graph where rGraph[i][j] indicates
        // residual capacity of edge from i to j (if there
        // is an edge. If rGraph[i][j] is 0, then there is
        // not)
        int rGraph[][] = new int[V][V];

        for (u = 0; u < V; u++)
            for (v = 0; v < V; v++)
                rGraph[u][v] = graph[u][v];

        // This array is filled by BFS and to store path
        int parent[] = new int[V];

        int max_flow = 0; // There is no flow initially

        // Augment the flow while there is path from source
        // to sink
        while (bfs(rGraph, s, t, parent)) {
            // Find minimum residual capacity of the edhes
            // along the path filled by BFS. Or we can say
            // find the maximum flow through the path found.
            int path_flow = Integer.MAX_VALUE;
            for (v = t; v != s; v = parent[v]) {
                u = parent[v];
                path_flow
                    = Math.min(path_flow, rGraph[u][v]);
            }

            // update residual capacities of the edges and
            // reverse edges along the path
            for (v = t; v != s; v = parent[v]) {
                u = parent[v];
                rGraph[u][v] -= path_flow;
                rGraph[v][u] += path_flow;
            }

            // Add path flow to overall flow
            max_flow += path_flow;
        }

        // Return the overall flow
        return max_flow;
    }

    // Driver program to test above functions
    public static void main(String[] args)
        throws java.lang.Exception
    {
        if(args.length>0) {
            int i;
            int vNum = args.length;
            int[][] GR = new int[vNum][vNum];

            for (int[] row: GR)
                Arrays.fill(row, 0);
            for(i=0;i<args.length;i++){
                String[] vArray = args[i].split(":");
                int u,v = 0,w;
                u = Integer.parseInt(vArray[0]);
                if(vArray.length>1){
                    for (int j = 1;j<vArray.length;j++){
                        if(j % 2 == 0){
                            w = Integer.parseInt(vArray[j]);
                            GR[u][v]=w;
                        }else{
                            v = Integer.parseInt(vArray[j]);
                        }
                    }
                }
            }
            FordFalkerson m = new FordFalkerson();

            System.out.print(m.fordFulkerson(GR, 0, vNum-1));
        }
    }
}
