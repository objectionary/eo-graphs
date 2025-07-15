#
<img src="https://www.yegor256.com/images/books/elegant-objects/cactus.svg"
height="100px"  alt="logo"/>

![workflow badge](https://github.com/potatmen/eo-graphs/actions/workflows/run-tests.yml/badge.svg)

Is it possible to implement sufficiently complex algorithms with [EO](https://github.com/cqfn/eo)?
Can EO handle large input datasets? Can EO code be functional, useful,
and idiomatic?
We addressed these questions by implementing several classic graph algorithms 
in three programming languages: Java, C++, and EO.
We compared their outputs and performance metrics on the same input data.
We chose graph algorithms because they are complex enough to challenge a small
and young language, yet they demonstrate how real-world algorithms might look
in EO.

To see the latest results, [run-tests.yml](https://github.com/HSE-Eolang/eo_graphs/actions/workflows/run-tests.yml)
and then to the tabs "Compare Results" and "Test Performance".

You'll need Java 11+, C++ and [Maven](https://maven.apache.org/) installed and:

```shell
make
make run
```

By the way, the graphs are generated randomly by the [utility](https://github.com/potatmen/eo-graphs/blob/master/src/java/generator/GraphGenerator.java) written in Java.

## Algorithms

The following graph algorithms are implemented:

[Dijkstra's algorithm](https://www.freecodecamp.org/news/dijkstras-shortest-path-algorithm-visual-introduction/)
<br/>
Dijkstra's algorithm finds the shortest path between nodes in a graph. 
Specifically, it finds the shortest path from a node (called the "source node")
to all other nodes in the graph, producing a shortest-path tree.
This algorithm is used in GPS devices to find the shortest path between the 
current location and the destination. It has broad applications in industry,
especially in domains that require modeling networks.

[Prim's algorithm](https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/)
<br/>
Prim's algorithm is an algorithm for constructing the minimum spanning tree of 
a connected weighted undirected graph. Prim's algorithm finds the subset of 
edges that includes every vertex of the graph such that the sum of the weights
of the edges can be minimized.
First, a random vertex is selected. The edge of the minimum weight incident to
the selected vertex is searched for. This is the first edge of the spanning
tree.
Next, an edge of the graph of the minimum weight is added to the tree in which
only one of the vertices belongs to the tree.
When the number of tree edges is equal to the number of nodes in the graph
minus one (the number of nodes in the graph and the tree are equal), 
the algorithm ends.

[Kruskal's algorithm](https://www.geeksforgeeks.org/kruskals-minimum-spanning-tree-algorithm-greedy-algo-2/)
<br/>
Kruskal's algorithm finds the minimum spanning tree for a connected weighted
graph. The algorithm's goal is to find the subset of edges that allows 
traversal of every vertex in the graph. Kruskal's algorithm follows a greedy
approach, finding an optimum solution at every stage instead of focusing on 
a global optimum.

[Ford-Fulkerson algorithm](https://www.geeksforgeeks.org/ford-fulkerson-algorithm-for-maximum-flow-problem/)
<br/>
The Ford-Fulkerson algorithm tackles the max-flow min-cut problem. Given 
a network with vertices and edges that have certain weights, it determines 
how much "flow" the network can process at a time. Flow can mean anything 
but typically refers to data through a computer network.
It was discovered in 1956 by Ford and Fulkerson. This algorithm is sometimes
referred to as a method because parts of its protocol are not fully specified
and can vary from implementation to implementation. An algorithm typically
refers to a specific protocol for solving a problem, whereas a method is 
a more general approach to a problem.
