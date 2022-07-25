.ONESHELL:
shell = bash
G = $$(cat tests/star.graph)
RUNJ = java -cp targets/java/
TARGPATH = ../../targets

C = printcpp() { \
	echo "C++:"; \
	if [ $$? -eq 0 ]; then \
    	echo "$$@"; \
  	else \
    	echo "Execution error"; \
  	fi \
}

J = printjava() { \
	echo "Java:"; \
	if [ $$? -eq 0 ]; then \
    	echo "$$@"; \
  	else \
    	echo "Execution error"; \
  	fi \
}

E = printeo() { \
	echo "EO:"; \
	if [ $$? -eq 0 ]; then \
    	echo "$$@"; \
  	else \
    	echo "Execution error"; \
  	fi \
}



compile:
	@rm -f -r targets/
	@mkdir targets/
	@mkdir targets/cpp
	@mkdir targets/java
	@cd src/cpp/
	for FILE in *; do \
		g++ $$FILE -o $(TARGPATH)/cpp/$${FILE%.cpp}; \
	done \
    
	@cd ../java
	for FILE in **/*.java; do \
		javac -d $(TARGPATH)/java $$FILE; \
	done
run:
	@java -cp targets/java/ GraphGenerator 0 10 > tests/edges/star3.graph
	@java -cp targets/java/ GraphGenerator 1 10 > tests/list/dijkstra2.graph
	@cd tests/edges
	@echo "====================================== Kruskal's algorithm ======================================";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE)"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Kruskal $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/kruskal $$var); \
		echo "\n";
	done

	@echo "====================================== Prim's algorithm ======================================";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE)"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java prim/PrimMST $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/prim $$var); \
		echo "\n";
	done
    
	@cd ../list
	@echo "====================================== Dijkstra's  algorithm ======================================";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE)"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java Dijkstra $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/dijkstra $$var); \
		echo "\n";
	done

	@echo "====================================== Ford-Fulkerson  algorithm ======================================";
	@for FILE in *; do \
	    var=$$(cat $$FILE)
		echo "Test ($$FILE)"; \
		$(J); printjava $$(java -cp $(TARGPATH)/java FordFalkerson $$var); \
		$(C); printcpp $$($(TARGPATH)/cpp/fordfalkersonalg $$var); \
		echo "\n";
	done

clean:
	rm -f -r targets/
	rm -f tests/edges/star3.graph
	rm -f tests/list/dijkstra2.graph