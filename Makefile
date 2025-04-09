# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

.ONESHELL:
shell = bash
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

compile: cpp java eo

cpp:
	$(MAKE) -C src/cpp

java:
	$(MAKE) -C src/java

eo:
	$(MAKE) -C src/eo/kruskal
	$(MAKE) -C src/eo/prim
	$(MAKE) -C src/eo/dijkstra
	$(MAKE) -C src/eo/fordfulkerson

run: compile
	@echo "======================================== \n";
	@echo "Now we are going to run Kruskal's algorithm \n";
	@for FILE in tests/edges/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH_JAVA) Kruskal $$var); \
		$(C); printcpp $$($(TARGPATH_CPP)/kruskal.o $$var);
		$(E); printeo $$(eoc --target src/eo/kruskal/.eoc --easy --alone dataize kruskalApp $$var);
	@echo "\n";
	done
	@echo "End of Kruskal's algorithm run\n";
	@echo "======================================== \n";
	@echo "Now we are going to run Prim's algorithm \n";
	@for FILE in tests/edges/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH_JAVA) prim/PrimMST $$var); \
		$(C); printcpp $$($(TARGPATH_CPP)/prim.o $$var);
		$(E); printeo $$(eoc --target src/eo/prim/.eoc --easy --alone dataize primApp $$var);
	@echo "\n";
	done
	@echo "End of Prim's algorithm run\n";
	@echo "======================================== \n";
	@echo "Now we are going to run Dijkstra's algorithm \n";
	@for FILE in tests/list/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH_JAVA) Dijkstra $$var); \
		$(C); printcpp $$($(TARGPATH_CPP)/dijkstra.o $$var);
		$(E); printeo $$(eoc --target src/eo/dijkstra/.eoc --easy --alone dataize dijkstraApp $$var);
		echo "\n";
	done
	@echo "End of Dijkstra's algorithm run\n";
	@echo "======================================== \n";
	@echo "Now we are going to run FordFulkerson's algorithm \n";
	@for FILE in tests/list/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH_JAVA) FordFalkerson $$var); \
		$(C); printcpp $$($(TARGPATH_CPP)/fordfalkersonalg.o $$var);
		echo "\n";
	done
	@echo "End of FordFulkerson's algorithm run\n";
	@echo "======================================== \n";

clean:
	$(MAKE) -C src/eo/kruskal clean
	$(MAKE) -C src/eo/prim clean
	$(MAKE) -C src/eo/dijkstra clean
	rm -rf targets/
