require File.dirname(__FILE__) + '/spec_helper.rb'
#    attr_accessor :direction, :speed_name, :speed_mps
describe Yr::Wind do
  it "should render correctly with unset values" do
    wind = Yr::Wind.new
    wind.to_s.should == " mps ( from )"
    wind.direction = "NE"
    wind.to_s.should == " mps ( from NE)"
    wind.speed_name = "Flau vind"
    wind.to_s.should == " mps (Flau vind from NE)"
    wind.speed_mps = 22
    wind.to_s.should == "22 mps (Flau vind from NE)"
  end
end