require File.dirname(__FILE__) + '/spec_helper.rb'

describe Yr::Symbol do
  before(:each) do
  end
  
  it "should render its icon correctly" do
    sym = Yr::Symbol.new(22, "CLOUDED")
    sym.icon.should == "http://api.yr.no/weatherapi/weathericon/1.0/?symbol=22;content_type=image/png"
  end
end