.ONESHELL:
shell = bash
TARGPATH = ../../targets

run:
	@mkdir $(TARGPATH)/cpp
	for FILE in *; do \
		if [ $$FILE != "Makefile" ]; then \
			g++ $$FILE -o $(TARGPATH)/cpp/$${FILE%.cpp}; \
		fi \
	done
