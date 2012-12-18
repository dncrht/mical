require 'spec_helper'

describe Event do

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