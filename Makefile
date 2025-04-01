# # SPDX-FileCopyrightText: Copyright (c) 2020-2025 Objectionary
# # SPDX-License-Identifier: MIT

.ONESHELL:
shell = bash
TARGPATH = targets

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

run: compile
	@for FILE in tests/edges/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Kruskal $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/kruskal.o $$var);
		$(E); printeo $$(eoc --easy --alone dataize kruskalApp $$var);
		echo "\n";
	done
	@for FILE in tests/edges/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java PrimMST $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/prim.o $$var);
		$(E); printeo $$(eoc --easy --alone dataize primApp $$var);
		echo "\n";
	done
	@for FILE in tests/list/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Dijkstra $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/dijkstra.o $$var);
		$(E); printeo $$(eoc --easy --alone dataize dijkstraApp $$var);
		echo "\n";
	done
	@for FILE in tests/list/*; do \
	  var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java FordFalkerson $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/fordfalkersonalg.o $$var);
		echo "\n";
	done

clean:
	$(MAKE) -C src/eo/kruskal clean
	$(MAKE) -C src/eo/prim clean
	$(MAKE) -C src/eo/dijkstra clean
	rm -rf targets/


# compile:
# 	@rm -f -r targets/
# 	@mkdir targets/
# 	@cd src/cpp
# 	@make
# 	@cd ../java
# 	@make
# 	@cd ../eo
# 	@cd prim/
# 	@eoc --easy link primApp
# 	@cd ../kruskal/
# 	@eoc --easy link kruskalApp
# run:
# 	@clear
# 	@cd tests/edges
# 	@echo "Now we are going to run Kruskal's algorithm \n";
# 	@for FILE in *; do \
# 	    var=$$(cat $$FILE)
# 		echo "Test ($$FILE) is running"; \
# 		$(J); printjava $$(java -cp $(TARGPATH)/java Kruskal $$var); \
# 		$(C); printcpp $$($(TARGPATH)/cpp/kruskal $$var);
# 	@cd ../../src/eo/kruskal
# 		$(E); printeo $$(eoc --easy --alone dataize kruskalApp $$var);
# 	@cd ../../../tests/edges/
# 		echo "\n";
# 	done
# 	@echo "Now we are going to run Prim's algorithm \n";
# 	@for FILE in *; do \
# 	    var=$$(cat $$FILE)
# 		echo "Test ($$FILE) is running"; \
# 		$(J); printjava $$(java -cp $(TARGPATH)/java prim/PrimMST $$var); \
# 		$(C); printcpp $$($(TARGPATH)/cpp/prim $$var);
# 	@cd ../../src/eo/prim
# 		$(E); printeo $$(eoc --easy --alone dataize primApp $$var);
# 	@cd ../../../tests/edges/
# 		echo "\n";
# 	done
# 	@cd ../list
# 	@echo "Now we are going to run Dijkstra's algorithm \n";
# 	@for FILE in *; do \
# 	    var=$$(cat $$FILE)
# 		echo "Test ($$FILE) is running"; \
# 		$(J); printjava $$(java -cp $(TARGPATH)/java Dijkstra $$var); \
# 		$(C); printcpp $$($(TARGPATH)/cpp/dijkstra $$var);
# 	@cd ../../src/eo/dijkstra
# 	@cd ../../../tests/list/
# 		echo "\n";
# 	done
# 	@echo "Now we are going to run Ford-Falkerson algorithm \n";
# 	@for FILE in *; do \
# 	    var=$$(cat $$FILE)
# 		echo "Test ($$FILE) is running"; \
# 		$(J); printjava $$(java -cp $(TARGPATH)/java FordFalkerson $$var); \
# 		$(C); printcpp $$($(TARGPATH)/cpp/fordfalkersonalg $$var); \
# 		echo "\n";
# 	done

# clean:
# 	rm -f -r targets/
# 	rm -f -r src/eo/prim/.eoc
# 	rm -f -r src/eo/kruskal/.eoc
# 	rm -f -r src/eo/dijkstra/.eoc
# 	rm -f -r src/eo/.eoc
