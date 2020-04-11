require "yaml"
require "pretty"

require "./shard/*"

module Shard
  ######################################################################
  ### API

  def []?(key) : YAML::Any::Type?
    DATA[key]?.try(&.raw)
  end

  def [](key) : YAML::Any::Type
    self[key]? || raise NotFound.new(key)
  end

  ######################################################################
  ### Git repository

  def git_version
    Git.version
  end

  def git_description
    Git.description
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

  def to_s(io : IO)
    git_description
  end

  extend self
end
