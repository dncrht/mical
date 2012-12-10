require 'spec_helper'

describe Event do

  it 'should not replace without day' do
    Event.replace(nil, nil, nil).should be_nil
  end
  
  it 'should replace when giving a date and the record exists' do
    Event.replace('1995-01-28', nil, nil).should be_an_instance_of Event
  end
  
  it 'should replace when giving a date and the record is new' do
    Event.replace('1992-01-28', nil, nil).should be_an_instance_of Event
  end
  
end