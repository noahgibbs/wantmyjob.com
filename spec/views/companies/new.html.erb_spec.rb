require 'spec_helper'

describe "companies/new.html.erb" do
  before(:each) do
    assign(:company, stub_model(Company,
      :company_name => "MyString",
      :apply_email => "MyString",
      :verified => false
    ).as_new_record)
  end

  it "renders new company form" do
    render

    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "form", :action => companies_path, :method => "post" do
      assert_select "input#company_company_name", :name => "company[company_name]"
      assert_select "input#company_apply_email", :name => "company[apply_email]"
      assert_select "input#company_verified", :name => "company[verified]"
    end
  end
end
