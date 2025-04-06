# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

EO_FILES := $(wildcard kruskal.eo)
EOC_FILES := .eoc

compile: $(EOC_FILES)

$(EOC_FILES): $(EO_FILES)
	eoc --easy link kruskalApp

clean:
	rm -rf .eoc
