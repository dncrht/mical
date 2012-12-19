require 'spec_helper'

describe 'routes.rb' do

  # RESTful resources are supposed to be ok
  
  it 'should route frontend routes' do
    { :get => '/2012' }.
      should route_to(
      :controller => 'home',
      :action => 'index',
      :year => '2012'
    )
  
    { :get => '/admin' }.
      should route_to(
      :controller => 'admin',
      :action => 'index'
    )

    { :put => '/action' }.
      should route_to(
      :controller => 'home',
      :action => 'replace'
    )

    { :delete => '/action' }.
      should route_to(
      :controller => 'home',
      :action => 'destroy'
    )

    { :get => '/' }.
      should route_to(
      :controller => 'home',
      :action => 'index'
    )
  end
  
  it 'should not route wrong frontend routes' do
    { :get => '/dummy_string' }.
      should_not route_to(
      :controller => 'home',
      :action => 'index',
      :year => 'dummy_string'
    )

    { :post => '/action' }.
      should_not route_to(
      :controller => 'home',
      :action => 'replace'
    )

    { :get => '/action' }.
      should_not route_to(
      :controller => 'home',
      :action => 'destroy'
    )
  end
end