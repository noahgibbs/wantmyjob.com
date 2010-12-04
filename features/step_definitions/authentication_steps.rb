# Confirmation
Given /^I received the email$/ do
  @user.confirmed?.should be_false
end

When /^I confirm the account$/ do
  visit user_confirmation_path(:confirmation_token => @user.confirmation_token)
  page.should have_content("Your account was successfully confirmed")
  @user.confirm!
end

Then /^I should find that I am confirmed$/ do
  @user.confirmed?.should be_true
end

# Forgottenpassword
Given /^that I have a confirmed account$/ do
  @user.confirmed?
end

Given /^that a confirmed user exists$/ do
  @user = Factory(:minimal_user)
end

Given /^that I have reset my password$/ do
  @user.send_reset_password_instructions
end

When /^I follow the reset password link in my email$/ do
  visit edit_user_password_path(:reset_password_token => @user.reset_password_token)
  page.should have_content("Change your password")
end

Then /^I expect to be able to reset my password$/ do
  visit edit_user_password_path(:reset_password_token => @user.reset_password_token)
  fill_in 'user_password', :with => 'test1234'
  fill_in 'user_password_confirmation', :with => 'test1234'
  click_button('Change my password')
  page.should have_content('Your password was changed successfully')
end

# Session
Given /^I am logged in$/ do
  visit path_to('the login page')
  fill_in('user_email', :with => @user.email)
  fill_in('user_password', :with => @user.password)
  click_button('Sign in')
  if defined?(Spec::Rails::Matchers)
    page.should have_content('Signed in successfully')
  else
    assert page.has_content?('Signed in successfully')
  end
end
