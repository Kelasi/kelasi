require 'spec_helper'

describe 'routing to frontend' do
  it 'should route the root_path to frontend/pages#page' do
    expect(get: '/').to route_to(
      controller: 'frontend/pages',
      action: 'page'
    )
  end

  it 'should route /fe_/:page to frontend/pages#page for page' do
    expect(get: '/fe_/some_page').to route_to(
      controller: 'frontend/pages',
      action: 'page',
      page: 'some_page'
    )
  end
end
