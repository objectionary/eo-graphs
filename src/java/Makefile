# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

.PHONY: all clean ltex vale spell
.ONESHELL:
.SHELLFLAGS := -e -o pipefail -c
.SECONDARY:
SHELL := bash

JAVA_FILES := $(wildcard **/*.java)
CLASS_FILES := $(JAVA_FILES:.java=.class)

compile: $(CLASS_FILES)

%.class: %.java
	javac -d targets/ $<

clean:
	rm -rf targets/
