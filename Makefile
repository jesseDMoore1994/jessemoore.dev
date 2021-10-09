VENV?=venv
VENV_ACTIVATE=. $(VENV)/bin/activate
PYTHON=$(VENV)/bin/python3
OUTPUT_FOLDER=$

$(VENV_ACTIVATE): requirements.txt
	python3 -m venv $(VENV)
	./$(VENV)/bin/pip install -r requirements.txt

output: $(VENV_ACTIVATE)
	$(VENV_ACTIVATE) && pelican content

host:
	$(VENV_ACTIVATE) && pelican -l output

clean:
	rm -rf output

clean-all:
	rm -rf venv output

.PHONY: clean clean-all host
