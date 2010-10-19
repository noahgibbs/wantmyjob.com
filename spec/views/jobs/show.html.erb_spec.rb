require 'spec_helper'

describe "jobs/show.html.erb" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :name => "Name",
      :foozle_count => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
