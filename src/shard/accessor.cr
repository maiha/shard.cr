module Shard
  ######################################################################
  ### Casting accessors

  macro casting_accessor(name, type)
    def {{name.id}}(key) : {{type.id}}
      v = self[key]
      if v.is_a?({{type.id}})
        v.as({{type.id}})
      else
        raise TypeMismatch.new(key, "{{type.id}}", v.class.name)
      end
    end

    def {{name.id}}?(key) : {{type.id}}?
      self[key]?.as({{type.id}}?)
    end
  end

  casting_accessor str    , String
  casting_accessor int    , Int32
  casting_accessor int32  , Int32
  casting_accessor int64  , Int64
  casting_accessor float  , Float32
  casting_accessor float32, Float32
  casting_accessor float64, Float64
  casting_accessor array  , Array

  ######################################################################
  ### Reserved names in default shard.yml

  macro field(name, method)
    def {{name.id}}
      {{method.id}}("{{name}}")
    end

    def {{name.id}}?
      {{method.id}}?("{{name}}")
    end
  end
end
