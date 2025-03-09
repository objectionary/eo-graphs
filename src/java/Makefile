# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

.ONESHELL:
shell = bash
TARGPATH = ../../targets

run:
	@mkdir $(TARGPATH)/java
	for FILE in **/*.java; do \
		javac -d $(TARGPATH)/java $$FILE; \
	done
