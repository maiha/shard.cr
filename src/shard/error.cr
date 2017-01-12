module Shard
  class NotFound < Exception
    getter key
    def initialize(@key : String)
      super("`#{@key}' is not found in shard.yml")
    end
  end

  class TypeMismatch < Exception
    getter key, expected, got
    def initialize(@key : String, @expected : String, @got : String)
      super("`#{key}' is expected for #{@expected}, but got #{@got}")
    end
  end
end
