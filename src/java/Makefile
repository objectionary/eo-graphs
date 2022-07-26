.ONESHELL:
shell = bash
TARGPATH = ../../targets

run:
	@mkdir $(TARGPATH)/java
	for FILE in **/*.java; do \
		javac -d $(TARGPATH)/java $$FILE; \
	done