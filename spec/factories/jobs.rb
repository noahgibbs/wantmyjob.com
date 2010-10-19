# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :job do |f|
  f.title "Master of Ceremonies"
  f.start_date Time.parse("July 3, 1991")
  f.end_date Time.parse("May 8, 1995")
  #f.work_site { f.association :work_site }
  #f.profile { f.association :profile }
  f.work_site { Factory.build :work_site }
  f.profile { Factory.build :profile }
end
