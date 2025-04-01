EO_FILES := $(wildcard prim.eo)
EOC_FILES := .eoc

compile: $(EOC_FILES)

$(EOC_FILES): $(EO_FILES)
	eoc --easy link primApp

clean:
	rm -rf .eoc
