# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

.PHONY: all clean ltex vale spell
.ONESHELL:
.SHELLFLAGS := -e -o pipefail -c
.SECONDARY:
SHELL := bash

EO_FILES := $(wildcard fordfulkerson.eo)
EOC_FILES := .eoc

compile: $(EOC_FILES)

$(EOC_FILES): $(EO_FILES)
	eoc --easy link fordfulkersonApp

clean:
	eoc clean
