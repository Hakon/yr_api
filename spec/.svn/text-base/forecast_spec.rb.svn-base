require File.dirname(__FILE__) + '/spec_helper.rb'

describe Yr::Forecast do
  before(:each) do
  end
  
  it "should create the correct time range" do
    forecast = Yr::Forecast.new
    forecast.from = Time.now
    forecast.to = forecast.from + 3600
    forecast.time_range.should == (forecast.from..forecast.to)
    forecast.time_range.should include(Time.now)
  end
end