require 'rspec'
require_relative '../space'

describe Space do 
  let (:space) { Space.new }

  it "a space knows when it's empty " do
    expect(space.filled?).to eq(false)
  end

  it "a space knows when its filled" do
    space.space = "Something"
    expect(space.filled?).to eq(true)
  end
  
end
