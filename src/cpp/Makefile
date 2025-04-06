# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

CPP_FILES := $(wildcard *.cpp)
BINARIES := $(addprefix ../../targets/cpp/, $(CPP_FILES:.cpp=.o))

compile: $(BINARIES)

../../targets/cpp/kruskal.o: kruskal.cpp
	mkdir -p ../../targets/cpp
	g++ $< -o $@

../../targets/cpp/prim.o: prim.cpp
	mkdir -p ../../targets/cpp
	g++ $< -o $@

../../targets/cpp/dijkstra.o: dijkstra.cpp
	mkdir -p ../../targets/cpp
	g++ $< -o $@

../../targets/cpp/fordfalkersonalg.o: fordfalkersonalg.cpp
	mkdir -p ../../targets/cpp
	g++ $< -o $@
