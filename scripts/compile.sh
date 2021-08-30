#!/bin/bash
mvn clean compile
mkdir target/cpp -p
gcc src/main/cpp/prim.cpp -lstdc++ -o target/cpp/prim
gcc src/main/cpp/dijkstra.cpp -lstdc++ -o target/cpp/dijkstra
gcc src/main/cpp/kruskal.cpp -lstdc++ -o target/cpp/kruskal
gcc src/main/cpp/fordfalkersonalg.cpp -lstdc++ -o target/cpp/fordfalkersonalg