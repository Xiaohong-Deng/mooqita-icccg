require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "wait_for_ajax"))

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    User.create!(user)
  end
end

Given /the following documents exist/ do |docs_table|
  docs_table.hashes.each do |doc|
    Document.create!(doc)
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
