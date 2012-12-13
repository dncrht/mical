#the uniqueness of the email assures these users are not created twice

User.create({
    email: 'admin',
    password: '21232f297a57a5a743894a0e4a801fc3', #admin
    can_download: true,
    can_edit_activity: true,
    can_edit_event: true,
    can_see_legend: true,
    can_see_description: true
  })

User.create({
    email: 'guest',
    password: "doesn't matter",
    can_download: false,
    can_edit_activity: false,
    can_edit_event: false,
    can_see_legend: false,
    can_see_description: false
  })
