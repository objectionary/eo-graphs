# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

JAVA_FILES := $(wildcard dijkstra/*.java fordfalkersonalg/*.java generator/*.java kruskal/*.java prim/*.java)
CLASS_FILES := $(JAVA_FILES:.java=.class)

# compile: compile_dijkstra compile_kruskal compile_prim compile_fordfulkerson

compile: dijkstra/*.class fordfalkersonalg/*.class kruskal/*.class prim/*.class generator/*.class

dijkstra/%.class: dijkstra/%.java
	javac $< -d ../../targets/java/dijkstra

fordfalkersonalg/%.class: fordfalkersonalg/%.java
	javac $< -d ../../targets/java/fordfulkerson

kruskal/%.class: kruskal/%.java
	javac $< -d ../../targets/java/kruskal

prim/%.class: prim/%.java
	javac $< -d ../../targets/java/

generator/%.class: generator/%.java
	javac $< -d ../../targets/java/generator
