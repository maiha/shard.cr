require "yaml"

require "./shard/*"

module Shard
  ######################################################################
  ### API

  def []?(key) : YAML::Type?
    DATA[key]?.try(&.raw)
  end

  def [](key) : YAML::Type
    self[key]? || raise NotFound.new(key)
  end

  ######################################################################
  ### Properties

  field name   , "str"
  field version, "str"
  field license, "str"
  field authors, "array"

  ######################################################################
  ### Convinient accessors

  def program
    name.gsub(/\.cr$/, "")
  end
  
  def time
    TIME
  end

  extend self
end
