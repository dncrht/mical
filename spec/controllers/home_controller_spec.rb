require 'spec_helper'

describe HomeController do
  fixtures :users

  it 'should not allow access' do
    get :replace
    response.should redirect_to(root_path)
  end
  
  it 'should replace an event' do
    @user = users(:admin)
    sign_in_as(@user)
    
    Event.stub!(:replace).and_return(Event.new(:day => Date.today))
    
    session[:logged_as] = 1 #admin
    get :replace
    response.should redirect_to("#{root_path}#{Date.today.year}")
  end
  
end