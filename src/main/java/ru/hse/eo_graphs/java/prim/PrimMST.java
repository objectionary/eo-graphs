package ru.hse.eo_graphs.java.prim;

import java.util.*;

public class PrimMST {
    private WeightGraph graph;
    private PriorityQueue<WeightGraph.Edge> minHeap;
    private boolean[] marked;
    private List<WeightGraph.Edge> mst;
    private Integer mstWeight;

    public PrimMST(WeightGraph graph) {
        this.graph = graph;
        minHeap = new PriorityQueue<>(Comparator.comparingInt(WeightGraph.Edge::getWeight));
        marked = new boolean[graph.getVertexNum()];
        mst = new ArrayList<>();

        visit(0);
        while (!minHeap.isEmpty()) {
            WeightGraph.Edge minEdge = minHeap.poll();
            if (marked[minEdge.getV()] && marked[minEdge.getW()]) {
                continue;
            }
            mst.add(minEdge);
            if (!marked[minEdge.getV()]) {
                visit(minEdge.getV());
            } else {
                visit(minEdge.getW());
            }
        }
    }

    public List<WeightGraph.Edge> getMst() {
        return mst;
    }

    public int getWeight() {
        int total = 0;
        for (WeightGraph.Edge edge : mst) {
            total += edge.getWeight();
        }
        return total;
    }

    private void visit(int v) {
        if (marked[v] || v >= graph.getVertexNum()) {
            return;
        }
        marked[v] = true;
        for (WeightGraph.Edge edge : graph.getGraph()[v]) {
            if (!marked[edge.getOther(v)]) {
                minHeap.offer(edge);
            }
        }
    }


    public static void main(String[] args) {
        int edgeNum = args.length / 3;
        if(edgeNum>0)
            try {
                List<WeightGraph.Edge> edges = new ArrayList<>();
                HashSet<Integer> vertices = new HashSet<>();
                for(int i = 0;i<edgeNum;i++){
                    int a = Integer.parseInt(args[i*3]);
                    int b = Integer.parseInt(args[i*3+1]);
                    int w = Integer.parseInt(args[i*3+2]);
                    edges.add(new WeightGraph.Edge(a, b, w));
                    vertices.add(a);
                    vertices.add(b);
                }

                WeightGraph graph = new WeightGraph(vertices.size());
                graph.addEdges(edges);

                PrimMST lazyPrimMST = new PrimMST(graph);
                System.out.print("MST: ");
                for(WeightGraph.Edge edge : lazyPrimMST.getMst())
                    System.out.print(edge);
            }catch (Exception e){
                System.exit(1);
            }

    }
}