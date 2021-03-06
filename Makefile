# shell option to use extended glob from from https://stackoverflow.com/a/6922447/1560241
SHELL:=/bin/bash -O extglob

VERSION=`< VERSION`

author=$(Ge Yang)
author_email=$(yangge1987@gmail.com)

# notes on python packaging: http://python-packaging.readthedocs.io/en/latest/minimal.html
default: ;
wheel:
	rm -rf dist
	python setup.py bdist_wheel
dev:
	make wheel
	pip install --ignore-installed dist/alice*.whl
convert-rst:
	pandoc -s README.md -o README --to=rst
	sed -i '' 's/code/code-block/g' README
	sed -i '' 's/\.\. code-block:: log/.. code-block:: text/g' README
	sed -i '' 's/\.\//https\:\/\/github\.com\/episodeyang\/alice\/blob\/master\//g' README
	perl -p -i -e 's/\.(jpg|png|gif)/.$$1?raw=true/' README
	rst-lint README
resize: # from https://stackoverflow.com/a/28221795/1560241
	echo ./figures/!(*resized).jpg
	convert ./figures/!(*resized).jpg -resize 888x1000 -set filename:f '%t' ./figures/'%[filename:f]_resized.jpg'
update-doc: convert-rst
	python setup.py sdist upload
release:
	git tag v$(VERSION) -m '$(msg)'
	git push origin --tags
publish: convert-rst
	#make test
	make wheel
	twine upload dist/*
test:
	python -m pytest alice_tests --capture=no
start-test-server:
	python -m alice.server --log-dir /tmp/ml-logger-debug
test-with-server:
	python -m pytest alice_tests --capture=no --log-dir http://0.0.0.0:8081
deploy-vis-app:
	git subtree push --prefix ml-vis-app/build ml-vis-ghpage gh-pages
deploy-vis-app-force:
	git push ml-vis-ghpage `git subtree split --prefix ml-vis-app/build`:gh-pages --force
build-vis-app:
	cd ml-vis-app && yarn build

