# SPDX-FileCopyrightText: Copyright (c) 2020-2026 Objectionary
# SPDX-License-Identifier: MIT

.PHONY: compile clean
.ONESHELL:
.SHELLFLAGS := -e -o pipefail -c
.SECONDARY:
SHELL := bash

ALGORITHMS = kruskal prim dijkstra fordfulkerson
EExec = eoc --easy --parser 0.61.3 --home-tag 0.61.3

compile:
	for algo in $(ALGORITHMS); do \
		( cd $$algo && $(EExec) link $${algo}App ); \
	done

clean:
	for algo in $(ALGORITHMS); do \
		( cd $$algo && eoc clean ); \
	done
