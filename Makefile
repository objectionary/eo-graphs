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

.PHONY: all compile cpp java eo run clean test

all: compile

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

target/run/%.txt: ALGO_NAME = $(subst kruskal,Kruskal's,$(subst prim,Prim's,$(subst dijkstra,Dijkstra's,$(subst fordfulkerson,FordFulkerson's,$*))))
target/run/%.txt: EOC_TARGET = src/eo/$*/.eoc
target/run/%.txt: TEST_DIR = $(if $(filter kruskal prim,$*),edges,list)

target/run/%.txt:
	@mkdir -p target/run
	@echo "========================================\n"
	@echo "Now we are going to run $(ALGO_NAME) algorithm\n"
	@for FILE in tests/$(TEST_DIR)/*; do \
		var=$$(cat $$FILE); \
		eoc --target $(EOC_TARGET) --easy --alone dataize $*App $$var; \
		echo $$? > $@; \
	done

clean:
	@for dir in src/eo/kruskal src/eo/prim src/eo/dijkstra src/eo/fordfulkerson src/java src/cpp; do \
		$(MAKE) -C $$dir clean; \
	done
	rm -rf target