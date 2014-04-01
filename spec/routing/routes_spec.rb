require 'spec_helper'

describe 'routes.rb' do

  # RESTful resources are supposed to be ok

  context 'route frontend routes' do
    it {
      expect(get: '/2012').to route_to(
        controller: 'home',
        action:     'index',
        year:       '2012'
      )
    }

    it {
      expect(get: '/admin').to route_to(
        controller: 'admin',
        action:     'index'
      )
    }

    it {
      expect(put: '/action').to route_to(
        controller: 'home',
        action:     'replace'
      )
    }

    it {
      expect(delete: '/action').to route_to(
        controller: 'home',
        action:     'destroy'
      )
    }

    it {
      expect(get: '/').to route_to(
        controller: 'home',
        action:     'index'
      )
    }
  end

  context 'don\'t route wrong frontend routes' do
    it {
      expect(get: '/dummy_string').to_not route_to(
        controller: 'home',
        action:     'index',
        year:       'dummy_string'
      )
    }

    it {
      expect(post: '/action').to_not route_to(
        controller: 'home',
        action:     'replace'
      )
    }

    it {
      expect(get: '/action').to_not route_to(
        controller: 'home',
        action:     'destroy'
      )
    }
  end
end
