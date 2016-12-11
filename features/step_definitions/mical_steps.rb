Given "there isn't an event for today" do
  create :activity
end

When 'I visit the calendar' do
  visit root_path
end

Given 'I click on today because I want to create an event' do
  find(:xpath, "//td[@data-day='#{Date.current.to_s}']").click
end

Given "there's an event for today" do
  @event = create :event
  @event_attributes = @event.attributes
end

Given 'I click on today because I want to modify an event' do
  find('.month-day_current').click
  expect(find('#event_description')).to have_content(Event.last.description)
end

When 'I add a description' do
  fill_in 'event_description', :with => 'new_description'
end

When 'I add a rating' do
  find_all('.event-form-rating span').last.click
end

When /^I click on (\w+)$/ do |button|
  click_button button
end

When 'I accept the confirm' do
  page.driver.browser.switch_to.alert.accept
end

Then 'the calendar should reload' do
  page.driver.browser.navigate.refresh
end

Then /^there must( not|) be an event for today$/ do |negation|
  if negation.present?
    expect(page).to_not have_css('.month-day_current.activity1')
  else
    expect(page).to have_css('.month-day_current.activity1')
    expect(Event.last.description).to eq 'new_description'
    expect(Event.last.rating).to eq 5
  end
end

Then /^the event must( not|) have been updated$/ do |negation|
  original_title = negation.present? ? 'original' : 'new'

  expect(Event.last.description).to eq "#{original_title}_description"
end

Given 'a logged in user' do
  user = create :user, password: 'kk'
  visit sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'kk'
  click_button 'Log me in!'
end

When 'debugger' do
  binding.pry
end
