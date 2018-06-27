require "./spec_helper"

describe Shard do
  describe ".time" do
    it "should return build time (Time)" do
      Shard.time.should be_a(Time)
    end
  end

  describe ".name" do
    it "should return package name (String)" do
      Shard.name.should eq("shard")
      Shard.name.should be_a(String)
    end
  end

  describe ".program" do
    it "should return compiled program name (String)" do
      Shard.program.should eq("shard")
      Shard.program.should be_a(String)
    end
  end

  describe ".version" do
    it "should return package version (String)" do
      Shard.version.should match(/^\d+\.\d+\.\d+$/)
      Shard.version.should be_a(String)
    end
  end

  describe ".license" do
    it "should return package license (String)" do
      Shard.license.should eq("MIT")
      Shard.license.should be_a(String)
    end
  end

  describe ".git_version" do
    it "should return git repository version (String)" do
      Shard.git_version.should match(/^\d+\.\d+\.\d+(\+\d+)?$/)
      Shard.git_version.should be_a(String)
    end
  end

  describe ".git_description" do
    it "should return git repository description (String)" do
      # expected: "shard 0.1.2+2 [f53da38] (2017-01-13)"
      Shard.git_description.should match(/^shard \d+\.\d+\.\d+(\+\d+)? /)
      Shard.git_description.should be_a(String)
    end
  end

  describe "#[key]" do
    it "should lookup the key (YAML::Any::Type)" do
      Shard["name"].should eq("shard")
      Shard["name"].should be_a(YAML::Any::Type)
    end

    it "should raise when the key is not found" do
      expect_raises Shard::NotFound do
        Shard["xxx"]
      end
    end
  end

  describe "#[key]?" do
    it "should lookup the key (YAML::Any::Type)" do
      Shard["name"]?.should eq("shard")
      Shard["name"]?.should be_a(YAML::Any::Type)
    end

    it "should return nil when the key is not found" do
      Shard["xxx"]?.should eq(nil)
      Shard["xxx"]?.should be_a(Nil)
    end
  end

  describe "#str(key)" do
    it "should lookup the key (String)" do
      Shard.str("name").should eq("shard")
      Shard.str("name").should be_a(String)
    end

    it "should raise when the key is not found" do
      expect_raises Shard::NotFound do
        Shard.str("xxx")
      end
    end

    it "should raise when the type is mismatch" do
      expect_raises Shard::TypeMismatch do
        Shard.str("authors")
      end
    end
  end

  describe "#str?(key)" do
    it "should lookup the key (String)" do
      Shard.str?("name").should eq("shard")
      Shard.str?("name").should be_a(String)
    end

    it "should return nil when the key is not found" do
      Shard.str?("xxx").should eq(nil)
      Shard.str?("xxx").should be_a(Nil)
    end

    it "should raise when the type is mismatch" do
      expect_raises Shard::TypeMismatch do
        Shard.str("authors")
      end
    end
  end
end
