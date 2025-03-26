# SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# SPDX-License-Identifier: MIT

.ONESHELL:
shell = bash
TARGPATH = ../../targets

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



compile:
	@rm -f -r targets/
	@mkdir targets/
	@cd src/cpp
	@make
	@cd ../java
	@make
run:
	@clear
	@cd tests/edges
	@echo "Now we are going to run Kruskal's algorithm \n";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Kruskal $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/kruskal $$var); \
		echo "\n";
	done

	@echo "Now we are going to run Prim's algorithm \n";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java prim/PrimMST $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/prim $$var); \

	@cd ../../src/eo/prim
		$(E); printeo $$(eoc --easy dataize primApp $$var)
	@cd ../../../tests/edges/
		echo "\n";
	done

	@cd ../list
	@echo "Now we are going to run Dijkstra's algorithm \n";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Dijkstra $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/dijkstra $$var); \
		echo "\n";
	done

	@echo "Now we are going to run Ford-Falkerson algorithm \n";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java FordFalkerson $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/fordfalkersonalg $$var); \
		echo "\n";
	done

clean:
	rm -f -r targets/
	rm -f -r src/eo/prim/.eoc
