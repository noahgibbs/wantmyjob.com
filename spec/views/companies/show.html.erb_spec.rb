require 'spec_helper'

describe "companies/show.html.erb" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :company_name => "Company Name",
      :apply_email => "Apply Email",
      :verified => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Company Name/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/Apply Email/)
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
