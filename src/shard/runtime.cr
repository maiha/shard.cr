module Shard
  ROOT = {{ env("PWD") || "." }}
  DATA = YAML.parse({{ system("cat " + (env("PWD") || ".") + "/shard.yml").stringify }})
  TIME = Time.unix({{ system("date '+%s'") }})
end
