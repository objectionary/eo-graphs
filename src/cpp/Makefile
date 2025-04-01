# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

CPP_FILES := $(wildcard *.cpp)
BINARIES := $(patsubst %, ../../targets/cpp/%, $(CPP_FILES:.cpp=.o))

compile: $(BINARIES)

$(BINARIES): $(CPP_FILES)
	mkdir -p ../../targets/cpp
	g++ $< -o $@
