require 'spec_helper'

describe "companies/index.html.erb" do
  before(:each) do
    assign(:companies, [
      stub_model(Company,
        :company_name => "Company Name",
        :apply_email => "Apply Email",
        :verified => false
      ),
      stub_model(Company,
        :company_name => "Company Name",
        :apply_email => "Apply Email",
        :verified => false
      )
    ])
  end

  it "renders a list of companies" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Apply Email".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
