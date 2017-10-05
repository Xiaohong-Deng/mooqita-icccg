require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "wait_for_ajax"))

Given /the following (.+)s exist/ do |obj_name, obj_table|
  obj_table.hashes.each do |obj|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    obj_name.classify.constantize.create!(obj)
  end
end


When /I sign in as "(.*)\/(.*)"/ do |email, password|
  step_cmds = ""
  step_cmds << %Q{When I fill in "user_email" with "#{email}"\n}
  step_cmds << %Q{And I fill in "user_password" with "#{password}"\n}
  step_cmds << %Q{And I press "Log in"\n}
  steps step_cmds
end

Given /I am in (.*) browser/ do |username|
  Capybara.session_name = username
end

Then /^(?:|I )should see "([^"]*)"$/ do |content|
  expect(page).to have_content content
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  expect(page).to have_current_path path_to(page_name)
end

Then /^I hit "(.+)" in "(.+)"$/ do |keystroke, field|
  find_field(field, options = { id: field }).send_keys keystroke.to_sym
end

# Given /^I wait for (\d+) seconds?$/ do |n|
#   sleep(n.to_i)
# end
