# shard.cr [![Build Status](https://travis-ci.org/maiha/shard.cr.svg?branch=master)](https://travis-ci.org/maiha/shard.cr)

compile-time shard.yml reader for [Crystal](http://crystal-lang.org/).

- Are you still dawdling in `version.cr` ?
- example: https://github.com/maiha/pcap.cr/commit/8a1f26e49223c431d7091b696ca72b9c2353276f

## API

```crystal
Shard.name        : String
Shard.version     : String
Shard.authors     : Array(String)
Shard.program     : String
Shard.time        : Time

Shard[key]        : YAML::Type
Shard[key]?       : YAML::Type?
Shard.str(key)    : String
Shard.str?(key)   : String?
Shard.int(key)    : Int32
Shard.int?(key)   : Int32?
Shard.array(key)  : Int32?
```

## Usage

```yaml
dependencies:
  shard:
    github: maiha/shard.cr
    version: 0.1.2
```

`Shard.xxx` returns the value.

```crystal
require "shard"

Shard.name   # => "foo"
Shard.vesion # => "0.1.0"
```

where assumed that we have following setting in `shard.yml` .

```yml
name: foo
version: 0.1.0
```

## Example

### Why don't you dry up `src/foo/version.cr` and `shard.yml` ?

1. Delete `src/foo/version.cr` 
2. Use `Shard.version` in anywhere you want.

Otherwise, use it in `src/foo/version.cr` .

```crystal
module Foo
  VERSION = Shard.version
end
```

### Creating license sessage

```crystal
license = Shard.license
year    = Shard.time.to_s("%Y")
author  = Shard.authors.first.to_s

puts "The %s License (%s)" % [license, license]
puts "Copyright (c) %s %s" % [year, author]
```

would print

```
The MIT License (MIT)
Copyright (c) 2016 maiha <maiha@wota.jp>
```

### more

See [spec/shard_spec.cr](spec/shard_spec.cr)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  shard:
    github: maiha/shard.cr
```

## Roadmap

#### 0.2.0

- [ ] `Shard.dependencies`

## Contributing

1. Fork it ( https://github.com/maiha/shard.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
