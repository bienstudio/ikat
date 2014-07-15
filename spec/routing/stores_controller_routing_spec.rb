require 'spec_helper'

describe StoresController, type: :controller do
  it '/:store_domain' do
    expect(
      get: '/foobar.com'
    ).to route_to(
      controller: 'stores',
      action: 'show',
      store_domain: 'foobar.com'
    )
  end
end
