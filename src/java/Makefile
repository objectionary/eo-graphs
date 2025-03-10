# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

.ONESHELL:
shell = bash
TARGPATH = ../../targets

run:
	@mkdir $(TARGPATH)/java
	for FILE in **/*.java; do \
		javac -d $(TARGPATH)/java $$FILE; \
	done
