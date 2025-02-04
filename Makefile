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
	@cd ../eo/prim
	@eoc dataize primApp --verbose --easy 0 1 0
	@cd ../kruskal
	@eoc dataize kruskalApp --verbose --easy 0 1 0
run:
	@clear
	# @java -cp targets/java/ GraphGenerator 0 10 > tests/edges/star3.graph
	# @java -cp targets/java/ GraphGenerator 1 10 > tests/list/dijkstra2.graph
	@cd tests/edges_kruskal
	@echo "Now we are going to run Kruskal's algorithm \n";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Kruskal $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/kruskal $$var); \
	
	@cd ../../src/eo/kruskal
		$(E); printeo $$(eoc --easy dataize kruskalApp $$var)
	@cd ../../../tests/edges_kruskal
		echo "\n";
	done

	@echo "Now we are going to run Prim's algorithm \n";
	@ cd ../edges_prim
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE) is running"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java prim/PrimMST $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/prim $$var); \
	  	
	@cd ../../src/eo/prim
		$(E); printeo $$(eoc --easy dataize primApp $$var)
	@ cd ../../../tests/edges_prim
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
	rm -f tests/edges/star3.graph
	rm -f tests/list/dijkstra2.graph
	rm -f -r src/eo/kruskal/.eoc
	rm -f -r src/eo/prim/.eoc