require 'spec_helper'

describe "jobs/edit.html.erb" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :new_record? => false,
      :fullname => "Harry Q. Bovik, Esq."
    ))
    @work_site = assign(:work_site, stub_model(WorkSite,
      :new_record? => false,
      :company_name => "BogoDyne"
    ))
    @job = assign(:job, stub_model(Job,
      :new_record? => false,
      :title => "Master of Ceremonies",
      :start_date => Time.parse("July 3, 1991"),
      :end_date => Time.parse("May 8, 1995"),
      :work_site => @work_site,
      :profile => @profile
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => job_path(@job), :method => "post" do
      assert_select "input#job_title", :name => "job[title]"
    end
  end
end
