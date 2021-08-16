#!/bin/bash
mvn clean compile
mkdir target/cpp -p
gcc src/main/cpp/prim.cpp -lstdc++ -o target/cpp/prim