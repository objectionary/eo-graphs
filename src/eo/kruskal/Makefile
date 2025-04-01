EO_FILES := $(wildcard kruskal.eo)
EOC_FILES := .eoc

compile: $(EOC_FILES)

$(EOC_FILES): $(EO_FILES)
	eoc --easy link kruskalApp

clean:
	rm -rf .eoc
