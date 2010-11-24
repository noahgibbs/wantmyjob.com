# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :company do |f|
  f.company_name "MyString"
  f.apply_email "MyString"
  f.verified false
end
