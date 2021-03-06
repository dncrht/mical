steps_for :calendar do

  step "there isn't an event for today" do
    FactoryBot.create :activity
  end

  step 'I visit the calendar' do
    visit root_path
  end

  step 'I click on today because I want to create an event' do
    find(:xpath, "//td[@data-day='#{Date.current.to_s}']").click
  end

  step "there's an event for today" do
    FactoryBot.create :event
  end

  step 'I click on today because I want to modify an event' do
    find('.month-day_current').click
    expect(find('textarea[name=event\[description\]]')).to have_content(Event.last.description)
  end

  step 'I add a description' do
    fill_in 'event[description]', with: 'new_description'
  end

  step 'I add a rating' do
    find_all('.event-form-rating span').last.click
  end

  step 'I click on :button' do |button|
    click_on button
  end

  step 'I accept the confirm' do
    page.driver.browser.switch_to.alert.accept
  end

  step 'the calendar should reload' do
    page.driver.browser.navigate.refresh
  end

  step 'there must be an event for today with top rating' do
    activity_selector = ".month-day_current.activity#{Event.last.activity.id}"

    expect(page).to have_css(activity_selector)
    expect(Event.last.description).to eq 'new_description'
    expect(Event.last.rating).to eq Event::TOP
  end

  step 'there must not be an event for today' do
    expect(Event.last).to be_nil
  end

  step 'the event must have been updated' do
    expect(Event.last.description).to eq "new_description"
  end

  step 'the event must not have been updated' do
    expect(Event.last.description).to eq "original_description"
  end

  step 'a logged in user' do
    user = FactoryBot.create :user, password: 'kk'
    visit sign_in_path
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: 'kk'
    click_button 'Log me in!'
  end

  step 'debugger' do
    binding.pry
  end
end
