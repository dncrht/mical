require 'spec_helper'

describe HomeController do
  
  let(:today) { Date.today }
  let(:admin) { FactoryGirl.build(:user) }
  let(:guest) { FactoryGirl.build(:user, can_edit_event: false) }
  let(:event) { FactoryGirl.create(:event) }
  
  context 'calendar' do
    
    before do
      Event.stub(:first).and_return(event)
    end
    
    it 'renders the current year' do
      get :index
      assigns(:activities).should_not be_nil
      assigns(:today).should eq today
      assigns(:year).should eq today.year
      assigns(:events).should be_an_instance_of ActiveSupport::HashWithIndifferentAccess
      
      response.should be_success
      response.should render_template('index')
    end
  
    it 'requesting the current year redirects to / to clean the URL' do
      get :index, :year => today.year
      response.should redirect_to(root_path)
    end
  
    it 'renders the selected year' do
      selected = rand(1996..2000)
      
      get :index, :year => selected
      assigns(:activities).should_not be_nil
      assigns(:today).should eq today
      assigns(:year).should eq selected
      assigns(:events).should be_an_instance_of ActiveSupport::HashWithIndifferentAccess
      
      response.should be_success
      response.should render_template('index')
    end
    
  end
  
  context 'alter event' do
  
    before do
      Event.stub(:replace).and_return(event)
    end
  
    it 'should not replace an event if not logged' do
      put :replace
      response.should redirect_to(root_path)
    end
  
    it "should not replace an event if logged and can't edit event" do
      sign_in_as guest
    
      put :replace
      response.should redirect_to(root_path)
    end
  
    it 'should replace an event if logged and can edit event' do
      sign_in_as admin
    
      put :replace
      response.should redirect_to("#{root_path}#{today.year}")
    end
    
  end
  
  context 'delete event' do
  
    it 'should not delete an event if not logged' do
      delete :destroy, :day => event.day
      Event.exists?(event.id).should be_true
      response.should redirect_to(root_path)
    end
  
    it "should not delete an event if logged and can't edit event" do
      sign_in_as guest
    
      delete :destroy, :day => event.day
      Event.exists?(event.id).should be_true
      response.should redirect_to(root_path)
    end
  
    it 'should redirect to / harmlessly if you try to delete but you not provide a day' do
      event
      sign_in_as admin
    
      delete :destroy
      Event.exists?(event.id).should be_true
      response.should redirect_to root_path
    end
  
    it 'should delete the given event if logged and can edit event' do
      sign_in_as admin
      delete :destroy, :day => event.day
      Event.exists?(event.id).should be_false
      response.should redirect_to("#{root_path}#{today.year}")
    end
  
  end
  
end