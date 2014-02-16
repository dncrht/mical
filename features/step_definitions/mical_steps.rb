Given "there isn't an event for today" do
  create :activity
end

When 'I visit the calendar' do
  visit root_path(as: create(:user))
end

Given 'I click on today because I want to create an event' do
  find(:xpath, "//td[@data-day='#{Date.current.to_s}']").click
end

Given "there's an event for today" do
  create :event
end

Given 'I click on today because I want to modify an event' do
  find('td.current').click
  find('#description').should have_content(Event.last.description)
end

When 'I add a description' do
  fill_in 'description', :with => 'new_description'
end

When /^I click on (\w+)$/ do |button|
  click_button button
end

When 'I accept the confirm' do
  page.driver.browser.switch_to.alert.accept
end

Then 'the calendar should reload' do
  current_path.should eq root_path
end

Then /^there must( not|) be an event for today$/ do |negation|
  if negation.present?
    page.should_not have_css('td.current.activity1')
  else
    page.should have_css('td.current.activity1')
  end
end

Then /^the event must( not|) have been updated$/ do |negation|
  if negation.present?
    find(:xpath, '//td[@data-original-title="original_description"]').should have_content(Event.last.day.day)
  else
    find(:xpath, '//td[@data-original-title="new_description"]').should have_content(Event.last.day.day)
  end
end