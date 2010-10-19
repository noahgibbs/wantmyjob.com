require 'spec_helper'

describe "jobs/new.html.erb" do
  before(:each) do
    assign(:job, stub_model(Job,
      :name => "MyString",
      :foozle_count => 1
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_name", :name => "job[name]"
      assert_select "input#job_foozle_count", :name => "job[foozle_count]"
    end
  end
end
