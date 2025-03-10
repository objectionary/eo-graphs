/**
 * SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
 * SPDX-License-Identifier: MIT
 */
import prim.WeightGraph;

import java.util.*;
import java.lang.*;

class Kruskal {



    class subset
    {
        int parent, rank;
    };

    int V, E;
    Edge edge[];

    Kruskal(int v, int e)
    {
        V = v;
        E = e;
        edge = new Edge[E];
        for (int i = 0; i < e; ++i)
            edge[i] = new Edge();
    }

    int find(subset subsets[], int i)
    {
        if (subsets[i].parent != i)
            subsets[i].parent = find(subsets, subsets[i].parent);

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
    void KruskalMST()
    {
        Edge result[] = new Edge[V];
        int e = 0;
        int i = 0;
        for (i = 0; i < V; ++i)
            result[i] = new Edge();
        Arrays.sort(edge);

        subset subsets[] = new subset[V];
        for (i = 0; i < V; ++i)
            subsets[i] = new subset();

        for (int v = 0; v < V; ++v)
        {
            subsets[v].parent = v;
            subsets[v].rank = 0;
        }

        i = 0;

        while (e < V - 1) {
            Edge next_edge = edge[i++];

            int x = find(subsets, next_edge.src);
            int y = find(subsets, next_edge.dest);

            if (x != y) {
                result[e++] = next_edge;
                Union(subsets, x, y);
            }
        }

        System.out.print("MST: ");
        for (i = 0; i < e; ++i) {
            System.out.print("(" + result[i].src + " "
                    + result[i].dest
                    + " - " + result[i].weight+") ");
        }
    }
    public static void main(String[] args)
    {
        int edgeNum = args.length / 3;
        if(edgeNum>0)
            try {

                List<Edge> edges = new ArrayList<>();
                HashSet<Integer> vertices = new HashSet<>();
                for(int i = 0;i<edgeNum;i++){
                    int a = Integer.parseInt(args[i*3]);
                    int b = Integer.parseInt(args[i*3+1]);
                    int w = Integer.parseInt(args[i*3+2]);
                    Edge edge = new Edge();
                    edge.src = a;
                    edge.dest = b;
                    edge.weight = w;
                    edges.add(edge);
                    vertices.add(a);
                    vertices.add(b);
                }
                Kruskal graph = new Kruskal(vertices.size(), edgeNum);

                for(int i = 0; i<edges.size();i++){
                    graph.edge[i] = edges.get(i);
                }

                // Function call
                graph.KruskalMST();
            }catch (Exception e){
                System.exit(1);
            }

    }
}

class Edge implements Comparable<Edge>
{
    int src, dest, weight;

    public int compareTo(Edge compareEdge)
    {
        return this.weight - compareEdge.weight;
    }
};
