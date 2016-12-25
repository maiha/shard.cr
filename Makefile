SHELL=/bin/bash

.PHONY : test
test: spec check_version_mismatch

.PHONY : spec
spec:
	@mkdir -p lib
	@rm -f lib/shard
	@ln -sf ../src lib/shard
	crystal spec -v --fail-fast

.PHONY : check_version_mismatch
check_version_mismatch: shard.yml README.md
	diff -w -c <(grep version: README.md | head -1) <(grep ^version: shard.yml)

