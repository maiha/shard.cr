require "./spec_helper"

# mock for license
def Time.unix(seconds : Int) : Time
  Pretty.now(2016, 3, 31)
end

describe "Examples" do
  it "(creating license)" do
    license = Shard.license
    year    = Shard.time.to_s("%Y")
    author  = Shard.authors.first.to_s

    got = String.build do |io|
      io << "The %s License (%s)\n" % [license, license]
      io << "Copyright (c) %s %s" % [year, author]
    end
    got.should eq <<-EOF
      The MIT License (MIT)
      Copyright (c) 2016 maiha <maiha@wota.jp>
      EOF
  end
end
