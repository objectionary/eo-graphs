# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

.ONESHELL:
shell = bash
TARGPATH_JAVA = src/java/targets
TARGPATH_CPP = src/cpp/targets

C = printcpp() { \
	echo "C++ gives this output:"; \
	if [ $$? -eq 0 ]; then \
    	echo "$$@"; \
  	else \
    	echo "Execution error"; \
  	fi \
}

J = printjava() { \
	echo "Java gives this output:"; \
	if [ $$? -eq 0 ]; then \
    	echo "$$@"; \
  	else \
    	echo "Execution error"; \
  	fi \
}

E = printeo() { \
	echo "EO gives this output:"; \
	if [ $$? -eq 0 ]; then \
    	echo "$$@"; \
  	else \
    	echo "Execution error"; \
  	fi \
}

compile: cpp java eo

cpp:
	$(MAKE) -C src/cpp

java:
	$(MAKE) -C src/java

eo:
	$(MAKE) -C src/eo/kruskal
	$(MAKE) -C src/eo/prim
	$(MAKE) -C src/eo/dijkstra
	$(MAKE) -C src/eo/fordfulkerson
	mkdir target target/run

run: target/run/kruskal.txt target/run/prim.txt target/run/dijkstra.txt target/run/fordfulkerson.txt

target/run/kruskal.txt:
	@echo "======================================== \n";
	@echo "Now we are going to run Kruskal's algorithm \n";
	@for FILE in tests/edges/*; do \
		var=$$(cat $$FILE)
		eoc --target src/eo/kruskal/.eoc --easy --alone dataize kruskalApp $$var
		echo $$? > $@
	done

target/run/prim.txt:
	@echo "======================================== \n";
	@echo "Now we are going to run Prim's algorithm \n";
	@for FILE in tests/edges/*; do \
	 	var=$$(cat $$FILE)
		eoc --target src/eo/prim/.eoc --easy --alone dataize primApp $$var
		echo $$? > $@
	done

target/run/dijkstra.txt:
	@echo "======================================== \n";
	@echo "Now we are going to run Dijkstra's algorithm \n";
	@for FILE in tests/list/*; do \
	 	var=$$(cat $$FILE)
		eoc --target src/eo/dijkstra/.eoc --easy --alone dataize dijkstraApp $$var
		echo $$? > $@
	done

target/run/fordfulkerson.txt:
	@echo "======================================== \n";
	@echo "Now we are going to run FordFulkerson's algorithm \n";
	@for FILE in tests/list/*; do \
	 	var=$$(cat $$FILE)
		@eoc --target src/eo/fordfulkerson/.eoc --easy --alone dataize fordfulkersonApp $$var
		@echo $$? > $@
	done

clean:
	$(MAKE) -C src/eo/kruskal clean
	$(MAKE) -C src/eo/prim clean
	$(MAKE) -C src/eo/dijkstra clean
	$(MAKE) -C src/eo/fordfulkerson clean
	$(MAKE) -C src/java clean
	$(MAKE) -C src/cpp clean
	rm -rf target