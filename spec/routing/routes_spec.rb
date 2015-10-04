require 'rails_helper'

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
      expect(get: '/events/2015-06-04').to route_to(
        controller: 'events',
        action:     'show',
        id:         '2015-06-04'
      )
    }

    it {
      expect(post: '/events').to route_to(
        controller: 'events',
        action:     'create'
      )
    }

    it {
      expect(patch: '/events/2015-06-04').to route_to(
        controller: 'events',
        action:     'update',
        id:         '2015-06-04'
      )
    }

    it {
      expect(delete: '/events/1').to route_to(
        controller: 'events',
        action:     'destroy',
        id:         '1'
      )
    }

    it {
      expect(post: '/assets').to route_to(
        controller: 'assets',
        action:     'create'
      )
    }

    it {
      expect(delete: '/assets/1').to route_to(
        controller: 'assets',
        action:     'destroy',
        id:         '1'
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
  end
end
