require 'spec_helper'

describe HomeController do
  
  context 'calendar' do
    
    it 'renders the current year' do
      today = Date.today
      
      get :index
      assigns(:activities).should_not be_nil
      assigns(:today).should eq today
      assigns(:year).should eq today.year
      assigns(:events).should be_an_instance_of ActiveSupport::HashWithIndifferentAccess
      
      response.should be_success
      response.should render_template('index')
    end
  
    it 'requesting the current year redirects to / to clean the URL' do
      get :index, :year => Date.today.year
      response.should redirect_to(root_path)
    end
  
    it 'renders the selected year' do
      selected = rand(1996..2000)
      
      get :index, :year => selected
      assigns(:activities).should_not be_nil
      assigns(:today).should eq Date.today
      assigns(:year).should eq selected
      assigns(:events).should be_an_instance_of ActiveSupport::HashWithIndifferentAccess
      
      response.should be_success
      response.should render_template('index')
    end
    
  end
  
  context 'alter event' do
  
    before do
      Event.stub(:replace).and_return(FactoryGirl.build(:event))
    end
  
    it 'should not replace an event if not logged' do
      get :replace
      response.should redirect_to(root_path)
    end
  
    it "should not replace an event if logged and can't edit event" do
      @user = FactoryGirl.build(:user, can_edit_event: false)
      sign_in_as(@user)
    
      get :replace
      response.should redirect_to(root_path)
    end
  
    it 'should replace an event if logged and can edit event' do
      @user = FactoryGirl.build(:user)
      sign_in_as(@user)
    
      get :replace
      response.should redirect_to("#{root_path}#{Date.today.year}")
    end
  
  end
  
end