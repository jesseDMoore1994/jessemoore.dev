VENV?=venv
VENV_ACTIVATE=. $(VENV)/bin/activate
PYTHON=$(VENV)/bin/python3
OUTPUT_FOLDER=$

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	./$(VENV)/bin/pip install -r requirements.txt

output: $(VENV)/bin/activate
	. $(VENV)/bin/activate && pelican content

host:
	. $(VENV)/bin/activate && pelican -l output

clean:
	rm -rf output

clean-all:
	rm -rf venv output

.PHONY: clean clean-all host
