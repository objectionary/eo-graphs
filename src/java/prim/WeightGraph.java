/**
 * SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
 * SPDX-License-Identifier: MIT
 */
package prim;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

public class WeightGraph {

    static class Edge {
        private int a;
        private int b;
        private int weight;

        public Edge(int a, int b, int weight) {
            this.a = a;
            this.b = b;
            this.weight = weight;
        }

        public Edge(Edge edge) {
            this.a = edge.a;
            this.b = edge.b;
            this.weight = edge.weight;
        }

        public int getV() {
            return a;
        }

        public int getW() {
            return b;
        }

        public int getWeight() {
            return weight;
        }

        public int getOther(int x) {
            assert x == a || x == b;
            return x == a ? b : a;
        }

        @Override
        public String toString() {
            return String.format("(%d %d - %d) ", a, b, weight);
        }

    }

    private int vertexNum;
    private int edgeNum;
    private List<Edge>[] graph;

    public WeightGraph(int vertexNum) {
        this.vertexNum = vertexNum;
        graph = (LinkedList<Edge>[]) new LinkedList[vertexNum];
        for (int i = 0; i < vertexNum; i++) {
            graph[i] = new LinkedList<>();
        }
    }

    public int getVertexNum() {
        return vertexNum;
    }

    public int getEdgeNum() {
        return edgeNum;
    }

    public List<Edge>[] getGraph() {
        return graph;
    }

    public void addEdge(int w, int v, int weight) {
        assert w >= 0 && w < vertexNum && v >= 0 && v < vertexNum;
        List<Edge> edges1 = graph[w];
        Edge newEdge1 = new Edge(w, v, weight);
        edges1.add(newEdge1);

        List<Edge> edges2 = graph[v];
        Edge newEdge2 = new Edge(v, w, weight);
        edges2.add(newEdge2);

        edgeNum++;
    }

    public void addEdges(List<Edge> edges) {
        for (Edge edge : edges) {
            List<Edge> edges1 = graph[edge.a];
            edges1.add(edge);

            List<Edge> edges2 = graph[edge.b];
            Edge newEdge = new Edge(edge.b, edge.a, edge.weight);
            edges2.add(newEdge);

            edgeNum++;
        }

    }
}
