Factory.define :job do |j|
  j.title "Master of Ceremonies"
  j.start_date Time.parse("July 3, 1991")
  j.end_date Time.parse("May 8, 1995")
  #j.association :work_site  # No good - won't work with attributes_for
  #j.association :profile    # No good - won't work with attributes_for
  j.work_site { Factory.build(:work_site) }
  j.profile { Factory.build(:profile) }
end
