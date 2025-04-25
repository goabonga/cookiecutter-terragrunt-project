BAKE_OPTIONS=--no-input

help:
	@echo "bake 	Generate project using defaults"
	@echo "help 	Show this help"
	@echo "test 	Run the tests"
	@echo "replay 	Replay last cookiecutter run and watch for changes"
	@echo "watch 	Generate project using defaults and watch for changes"
	

bake:  # Generate project using defaults
	poetry run cookiecutter $(BAKE_OPTIONS) . --overwrite-if-exists

watch: bake
	poetry run watchmedo shell-command -p '*.*' -c 'make bake -e BAKE_OPTIONS=$(BAKE_OPTIONS)' -W -R -D \{{cookiecutter.project_slug}}/

replay: BAKE_OPTIONS=--replay
replay: watch
	;

test:
	poetry run pytest tests/