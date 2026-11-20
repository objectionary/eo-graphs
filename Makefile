# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

.PHONY: all clean ltex vale spell
.ONESHELL:
.SHELLFLAGS := -e -o pipefail -c
.SECONDARY:
SHELL := bash

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

all: compile run

compile: cpp java eo

cpp:
	$(MAKE) -C src/cpp

java:
	$(MAKE) -C src/java

eo:
	$(MAKE) -C src/eo

run: target/run/kruskal.txt target/run/prim.txt target/run/dijkstra.txt target/run/fordfulkerson.txt

target/run/%.txt: ALGO_NAME = $(subst kruskal,Kruskal's,$(subst prim,Prim's,$(subst dijkstra,Dijkstra's,$(subst fordfulkerson,FordFulkerson's,$*))))
target/run/%.txt: EOC_TARGET = target/eo/$*
target/run/%.txt: TEST_DIR = $(if $(filter kruskal prim,$*),edges,list)

target/run/%.txt: | compile
	@mkdir -p target/run
	@echo "========================================\n"
	@echo "Now we are going to run $(ALGO_NAME) algorithm\n"
	@: > "$@.tmp"
	@for FILE in tests/$(TEST_DIR)/*; do \
		var=$$(cat "$$FILE"); \
		eoc --no-color --batch --blind --parser 0.63.2 --home-tag 0.63.2 --target $(EOC_TARGET) --alone dataize --heap=8G $*.$*App $$var >> "$@.tmp"; \
	done
	@mv "$@.tmp" "$@"

clean:
	@for dir in src/eo src/java src/cpp; do \
		$(MAKE) -C $$dir clean; \
	done
	rm -rf target
