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
	@cd ../eo/
	# @eoc dataize app --verbose
run:
	@clear
	@java -cp targets/java/ GraphGenerator 0 10 > tests/edges/star3.graph
	@java -cp targets/java/ GraphGenerator 1 10 > tests/list/dijkstra2.graph
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

	@cd ../../src/eo
	# 	$(E); printeo $$(eoc --alone dataize app $$var)
	@cd ../../tests/edges/
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
	rm -f -r src/eo/.eoc
