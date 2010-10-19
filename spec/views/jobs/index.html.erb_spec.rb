require 'spec_helper'

describe "jobs/index.html.erb" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job, Factory.attributes_for(:job)),
      stub_model(Job, Factory.attributes_for(:job, :employer => "Yoyodyne"))
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Master of Ceremonies".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
  end
end
