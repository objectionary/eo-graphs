EO_FILES := $(wildcard dijkstra.eo)
EOC_FILES := .eoc

compile: $(EOC_FILES)

$(EOC_FILES): $(EO_FILES)
	eoc --easy link dijkstraApp

clean:
	rm -rf .eoc
