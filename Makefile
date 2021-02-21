install: poetry.lock
	command -v poetry || pip install poetry
	poetry install

test:
	poetry run pytest tests/src

package:
	tools/releasing/package.sh

upload:
	tools/releasing/upload.sh

nuke:
	git reset --hard HEAD
	git clean -dfx