require 'spec_helper'

describe HomeController do
  
  before :all do
    @event = FactoryGirl.build(:event)
  end

  it 'should not allow access' do
    get :replace
    response.should redirect_to(root_path)
  end
  
  it 'should not replace an event if not logged' do
    Event.stub!(:replace).and_return(@event)
    
    get :replace
    response.should redirect_to(root_path)
  end
  
  it "should not replace an event if logged and can't edit event" do
    @user = FactoryGirl.create(:user, can_edit_event: false)
    sign_in_as(@user)
    
    Event.stub!(:replace).and_return(@event)
    
    get :replace
    response.should redirect_to(root_path)
  end
  
  it 'should replace an event if logged and can edit event' do
    @user = FactoryGirl.create(:user)
    sign_in_as(@user)
    
    Event.stub!(:replace).and_return(@event)
    
    get :replace
    response.should redirect_to("#{root_path}#{Date.today.year}")
  end
  
end