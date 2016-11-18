.PHONY : all test

all: test

test:
	@mkdir -p libs
	@rm -f libs/shard
	@ln -sf ../src libs/shard
	crystal spec -v --fail-fast
