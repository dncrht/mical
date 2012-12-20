require 'spec_helper'

describe Event do

  it 'has a valid factory' do
    FactoryGirl.build(:event).should be_valid
  end

  it 'is invalid without day' do
    FactoryGirl.build(:event, day: nil).should_not be_valid
  end
  
  it 'day should be unique' do
    FactoryGirl.create(:event)
    
    event = FactoryGirl.build(:event) # Same event
    event.should_not be_valid
    event.should have(1).error_on(:day)
  end
  
  it 'is invalid without activity' do
    FactoryGirl.build(:event, activity_id: nil).should_not be_valid
  end
  
  it 'is invalid without description' do
    FactoryGirl.build(:event, description: nil).should_not be_valid
  end
  
  it 'should not replace without day' do
    Event.replace(nil, nil, nil).should be_nil
  end
  
  it 'should replace when giving a date and the record exists' do
    @event = FactoryGirl.create(:event)
    
    replacement = Event.replace(@event.day, nil, nil)
    
    replacement.should be_an_instance_of Event
    replacement.description.should be_nil
  end
  
  it 'should replace when giving a date and the record is new' do
    @event = FactoryGirl.build(:event)
    
    replacement = Event.replace(@event.day, nil, nil)
    
    replacement.should be_an_instance_of Event
    replacement.description.should be_nil
  end
  
end