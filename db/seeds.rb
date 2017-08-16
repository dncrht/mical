user = User.new(
  email: 'admin@domain.tld', #the uniqueness of the email assures this user is not created twice
  password: 'admin',
  can_download: true,
  can_edit_activity: true,
  can_edit_event: true,
  can_see_legend: true,
  can_see_description: true
)
user.is_admin = true
user.save
