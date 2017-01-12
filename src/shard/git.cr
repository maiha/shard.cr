module Shard
  module Git
    ######################################################################
    ### derived from `src/compiler/crystal/config.cr`

    def self.version
      version_and_sha.first
    end

    def self.description
      version, sha = version_and_sha
      if sha
        "#{Shard.name} #{version} [#{sha}] (#{date})"
      else
        "#{Shard.name} #{version} (#{date})"
      end
    end

    @@version_and_sha : {String, String?}?

    def self.version_and_sha
      @@version_and_sha ||= compute_version_and_sha
    end

    private def self.compute_version_and_sha
      git_version = {{`(git describe --tags --long --always 2>/dev/null) || true`.stringify.chomp}}
      # Strip v for the tag version like "v0.1.2-1-g2ede982"
      git_version = git_version.sub(/^v/, "")

      # Failed git and no explicit version set: ""
      # We inherit the version of the compiler building us for now.
      return { Shard.version, nil } if git_version.empty?

      # Shallow clone with no tag in reach: abcd123
      # We assume being compiled with the latest released compiler
      return { Shard.version, git_version} unless git_version.includes? '-'

      # On release: 0.0.0-0-gabcd123
      # Ahead of last release: 0.0.0-42-gabcd123
      tag, commits, sha = git_version.split("-")
      sha = sha[1..-1]                                # Strip g
      tag = "#{tag}+#{commits}" unless commits == "0" # Reappend commits since release unless we hit it exactly

      {tag, sha}
    end

    def self.date
      {{ `date "+%Y-%m-%d"`.stringify.chomp }}
    end
  end
end
