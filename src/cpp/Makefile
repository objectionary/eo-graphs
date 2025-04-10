# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

CPP_FILES := $(wildcard *.cpp)
BINARIES := $(addprefix targets/, $(CPP_FILES:.cpp=.o))

compile: $(BINARIES)

targets/%.o: %.cpp
	mkdir -p targets/
	g++ $< -o $@

clean:
	rm -rf targets/
