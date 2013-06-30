require 'spec_helper'

describe 'routes.rb' do

  # RESTful resources are supposed to be ok

  context 'route frontend routes' do
    specify {
      { :get => '/2012' }.
        should route_to(
        :controller => 'home',
        :action => 'index',
        :year => '2012'
      )
    }

    specify {
      { :get => '/admin' }.
        should route_to(
        :controller => 'admin',
        :action => 'index'
      )
    }

    specify {
      { :put => '/action' }.
        should route_to(
        :controller => 'home',
        :action => 'replace'
      )
    }

    specify {
      { :delete => '/action' }.
        should route_to(
        :controller => 'home',
        :action => 'destroy'
      )
    }

    specify {
      { :get => '/' }.
        should route_to(
        :controller => 'home',
        :action => 'index'
      )
    }
  end

  context 'don\'t route wrong frontend routes' do
    specify {
      { :get => '/dummy_string' }.
        should_not route_to(
        :controller => 'home',
        :action => 'index',
        :year => 'dummy_string'
      )
    }

    specify {
      { :post => '/action' }.
        should_not route_to(
        :controller => 'home',
        :action => 'replace'
      )
    }

    specify {
      { :get => '/action' }.
        should_not route_to(
        :controller => 'home',
        :action => 'destroy'
      )
    }
  end
end