require 'spec_helper'

describe "jobs/show.html.erb" do
  before(:each) do
    @job = assign(:job, stub_model(Job, Factory.attributes_for(:job)))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/BogoDyne/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
  end
end
