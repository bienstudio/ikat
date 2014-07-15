require 'spec_helper'

describe UsersController, type: :controller do
  it '/:username' do
    expect(
      get: '/foobar'
    ).to route_to(
      controller: 'users',
      action: 'show',
      username: 'foobar'
    )
  end
end
