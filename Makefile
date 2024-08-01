MAKE=make --no-print-directory
SHELL=/bin/bash
.SHELLFLAGS = -o pipefail -c

TARGET=spec

all: ci

######################################################################
### testing

.PHONY : ci
ci:
	@echo "Please run test task with crystal version like this."
	@echo "  make test/1.13.1"

test/%: shard.lock
	@echo "----------------------------------------------------------------------"
	@echo "[$*] TARGET=$(TARGET) CFLAGS=$(CFLAGS)"
	@echo "----------------------------------------------------------------------"
	@docker run -t -u "`id -u`" -v "`pwd`:/v" -w /v --rm "crystallang/crystal:$*" crystal spec $(VERBOSE) $(CFLAGS) $(TARGET)

shard.lock: shard.yml
	shards update

######################################################################
### versioning

VERSION=
CURRENT_VERSION=$(shell git tag -l | sort -V | tail -1 | sed -e 's/^v//')
GUESSED_VERSION=$(shell git tag -l | sort -V | tail -1 | awk 'BEGIN { FS="." } { $$3++; } { printf "%d.%d.%d", $$1, $$2, $$3 }')

.PHONY : version
version:
	@if [ "$(VERSION)" = "" ]; then \
	  echo "ERROR: specify VERSION as bellow. (current: $(CURRENT_VERSION))";\
	  echo "  make version VERSION=$(GUESSED_VERSION)";\
	else \
	  sed -i -e 's/^version: .*/version: $(VERSION)/' shard.yml ;\
	  sed -i -e 's/^    version: [0-9]\+\.[0-9]\+\.[0-9]\+/    version: $(VERSION)/' README.md ;\
	  echo git commit -a -m "'$(COMMIT_MESSAGE)'" ;\
	  git commit -a -m 'version: $(VERSION)' ;\
	  git tag "v$(VERSION)" ;\
	fi

.PHONY : bump
bump:
	make version VERSION=$(GUESSED_VERSION) -s

