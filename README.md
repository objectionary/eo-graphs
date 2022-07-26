<img src="https://www.yegor256.com/images/books/elegant-objects/cactus.svg" height="100px" />

[![Latests Results](https://github.com/HSE-Eolang/eo_graphs/actions/workflows/run-tests.yml/badge.svg)](https://github.com/HSE-Eolang/eo_graphs/actions/workflows/run-tests.yml) 

Is it possible to implement hard enough algorithms with [EO](https://github.com/cqfn/eo)? Would EO manage big enough input data? May EO code be functional and useful, yet idiomatic? We tried to address these questions in this work. To do it, we implemented several classic graph algorithms in three programming languages: Java, C++, and EO. We compared their outputs and performance metrics on the same input data. Why did we choose graph algorithms? Well, graph algorithms are hard enough for such a small and young language. And still these algorithms may show how real-life algorithms might look like in EO.

To see the latest results, [click here](https://github.com/HSE-Eolang/eo_graphs/actions/workflows/run-tests.yml) and then to the tabs "Compare Results" and "Test Performance".

You will need Java 11+, C++, and [Maven](https://maven.apache.org/) installed, and then:

```
$ make
$ make run
```

By the way, the graphs are generated randomly by the [utility](https://github.com/HSE-Eolang/eo_graphs/blob/master/src/main/java/ru/hse/eo_graphs/GraphGenerator.java) written in Java.

## Algorithms 

The following graph algorithms are implemented:

[Dijkstra algorithms](https://www.freecodecamp.org/news/dijkstras-shortest-path-algorithm-visual-introduction/)
<br/>
With Dijkstra's Algorithm, you can find the shortest path between nodes in a graph. Particularly, you can find the shortest path from a node (called the "source node") to all other nodes in the graph, producing a shortest-path tree.
This algorithm is used in GPS devices to find the shortest path between the current location and the destination. It has broad applications in industry, specially in domains that require modeling networks.

[Prim's algorithm](https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/)
<br/>
Prim's algorithm is an algorithm for constructing the minimum spanning tree of a connected weighted undirected graph. Prim's algorithm finds the subset of edges that includes every vertex of the graph such that the sum of the weights of the edges can be minimized.
First, a random vertex is selected. The edge of the minimum weight incident to the selected vertex is searched for. This is the first edge of the spanning tree.
Next, an edge of the graph of the minimum weight is added to the tree in which only one of the vertices belongs to the tree.
When the number of tree edges is equal to the number of nodes in the graph minus one (the number of nodes in the graph and the tree are equal), the algorithm ends.

[Kruskal's algorithm](https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/)
<br/>
Kruskal's Algorithm is used to find the minimum spanning tree for a connected weighted graph. The main target of the algorithm is to find the subset of edges by using which, we can traverse every vertex of the graph. Kruskal's algorithm follows greedy approach which finds an optimum solution at every stage instead of focusing on a global optimum.

[Ford Falkeson's algorithm](https://www.geeksforgeeks.org/ford-fulkerson-algorithm-for-maximum-flow-problem/)
<br/>
The Ford-Fulkerson algorithm is an algorithm that tackles the max-flow min-cut problem. That is, given a network with vertices and edges between those vertices that have certain weights, how much "flow" can the network process at a time? Flow can mean anything, but typically it means data through a computer network.
It was discovered in 1956 by Ford and Fulkerson. This algorithm is sometimes referred to as a method because parts of its protocol are not fully specified and can vary from implementation to implementation. An algorithm typically refers to a specific protocol for solving a problem, whereas a method is a more general approach to a problem.
