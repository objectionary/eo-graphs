# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

.PHONY: all clean ltex vale spell
.ONESHELL:
.SHELLFLAGS := -e -o pipefail -c
.SECONDARY:
SHELL := bash

CLASS_FILES := targets/Dijkstra.class targets/FordFalkerson.class targets/Kruskal.class \
    targets/GraphGenerator.class targets/prim/WeightGraph.class targets/prim/PrimMST.class

compile: $(CLASS_FILES)

targets/Dijkstra.class: dijkstra/Dijkstra.java
targets/FordFalkerson.class: fordfalkersonalg/FordFalkerson.java
targets/Kruskal.class: kruskal/kruskal.java
targets/GraphGenerator.class: generator/GraphGenerator.java
targets/prim/WeightGraph.class: prim/WeightGraph.java
targets/prim/PrimMST.class: prim/PrimMST.java targets/prim/WeightGraph.class

$(CLASS_FILES):
	mkdir -p targets/
	javac -cp targets/ -d targets/ $<

clean:
	rm -rf targets/
