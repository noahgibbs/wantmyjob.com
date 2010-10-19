require 'spec_helper'

describe "jobs/edit.html.erb" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :new_record? => false,
      :name => "MyString",
      :foozle_count => 1
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => job_path(@job), :method => "post" do
      assert_select "input#job_name", :name => "job[name]"
      assert_select "input#job_foozle_count", :name => "job[foozle_count]"
    end
  end
end
