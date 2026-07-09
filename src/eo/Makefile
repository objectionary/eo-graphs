# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

.PHONY: compile clean
.ONESHELL:
.SHELLFLAGS := -e -o pipefail -c
.SECONDARY:
SHELL := bash

ALGORITHMS = kruskal prim dijkstra fordfulkerson
EExec = eoc --no-color --batch --parser 0.61.3 --home-tag 0.61.3

compile:
	for algo in $(ALGORITHMS); do \
		$(EExec) --target ../../target/eo/$$algo link $$algo.$${algo}App; \
	done

clean:
	rm -rf ../../target/eo
	find . -name .eoc -type d -prune -exec rm -rf {} +
