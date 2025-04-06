EO_FILES := $(wildcard fordfulkerson.eo)
EOC_FILES := .eoc

compile: $(EOC_FILES)

$(EOC_FILES): $(EO_FILES)
	eoc --easy link fordfulkersonApp

clean:
	rm -rf .eoc
