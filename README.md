## What this repository is for?

This repository proposes comparison between algorithmic graph realizations in C++,Java and EO.

## How to use

### Tools to be installed

#### Java
First, you need to install Java Development Kit (JDK) on your machine in order to build and work with eo_graphs. Version 11 of JDK would be a good option (you can find 
installation packages [here](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)). 

#### C++
Second, you need to install GCC on your machine in order to build and work with eo_graphs. Version 11.1 is optimal(you can find 
installation packages [here](https://gcc.gnu.org/gcc-11/)).

#### Maven
Third, you need to install Maven on your machine in order to build and work with eo_graphs. Version 3.8.2 is needed(you can find 
installation packages [here](https://maven.apache.org/download.cgi)).

### Downloading sources
Then, fork this repository with git:
```bash
git clone git@github.com:HSE-Eolang/eo_graphs.git
```

### Run scripts 
All scripts are running from the root folder of repository.

#### Сompilation of Java, EO and C ++ source codes

```bash
compile.sh
```

#### Comparing the results of executing programs in different languages, to make sure that the result is identical.

```bash
compare.sh
```

#### Testing of the execution time and memory consumption of programs on graphs of different sizes. 
Graphs are generated randomly by an [utility](https://github.com/HSE-Eolang/eo_graphs/blob/master/src/main/java/ru/hse/eo_graphs/GraphGenerator.java) written in Java.

```bash
test.sh
```

## Implemented algorithms 
The following graph algorithms are implemented.
- [Dijkstra algorithms](https://www.freecodecamp.org/news/dijkstras-shortest-path-algorithm-visual-introduction/).

With Dijkstra's Algorithm, you can find the shortest path between nodes in a graph. Particularly, you can find the shortest path from a node (called the "source node") to all other nodes in the graph, producing a shortest-path tree.

This algorithm is used in GPS devices to find the shortest path between the current location and the destination. It has broad applications in industry, specially in domains that require modeling networks.

- [Prim's algorithm](https://www.geeksforgeeks.org/prims-minimum-spanning-tree-mst-greedy-algo-5/).

Prim's algorithm is an algorithm for constructing the minimum spanning tree of a connected weighted undirected graph. Prim's algorithm finds the subset of edges that includes every vertex of the graph such that the sum of the weights of the edges can be minimized.

First, a random vertex is selected. The edge of the minimum weight incident to the selected vertex is searched for. This is the first edge of the spanning tree.
Next, an edge of the graph of the minimum weight is added to the tree in which only one of the vertices belongs to the tree.
When the number of tree edges is equal to the number of nodes in the graph minus one (the number of nodes in the graph and the tree are equal), the algorithm ends.
