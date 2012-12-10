require 'spec_helper'

describe HomeController do

  it 'should not allow access' do
    get :replace
    response.should redirect_to(root_path)
  end
  
  it 'should replace an event' do
    Event.stub!(:replace).and_return(Event.new(:day => Date.today))
    
    session[:logged_as] = 1 #admin
    get :replace
    response.should redirect_to("#{root_path}#{Date.today.year}")
  end
  
end