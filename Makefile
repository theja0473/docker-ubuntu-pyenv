# Development targets

IMAGE := bopen/ubuntu-pyenv

%.txt: %.in
	pip-compile $(PIPCOMPILEFLAGS) -o $@ $^

requirements-setup.txt: PIPCOMPILEFLAGS += --allow-unsafe

shell:
	docker run --rm -ti -v$$(pwd):/src -w/src $(DOCKERFLAGS) $(IMAGE)

image: requirements-setup.txt requirements-test.txt requirements-ci.txt
	docker build -t $(IMAGE) $(DOCKERBUILDFLAGS) .
