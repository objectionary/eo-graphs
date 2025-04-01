# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

JAVA_FILES := $(wildcard dijkstra/*.java FordFalkersonalg/*.java generator/*.java kruskal/*.java prim/*.java)
CLASS_FILES := $(JAVA_FILES:.java=.class)

compile: $(CLASS_FILES)

dijkstra/%.class: dijkstra/%.java
	javac $< -d ../../targets/java

fordfalkersonalg/%.class: fordfalkersonalg/%.java
	javac $< -d ../../targets/java

kruskal/%.class: kruskal/%.java
	javac $< -d ../../targets/java

prim/%.class: prim/%.java
	javac $< -d ../../targets/java

generator/%.class: generator/%.java
	javac $< -d ../../targets/java
