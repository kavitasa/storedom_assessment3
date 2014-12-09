require_relative '../test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_only_displays_active_items
    active_item = Item.create(name: 'Active_robot', active: true)
    inactive_item = Item.create(name: 'Inactive_drone')
    visit '/'
    assert page.has_content?('Active_robot')
    refute page.has_content?('Inactive_drone')
  end

  def test_it_displays_all_items_with_param
    active_item = Item.create(name: 'Active_robot', active: true)
    inactive_item = Item.create(name: 'Inactive_drone')
    visit '/?show_inactive=true'
    assert page.has_content?('Active_robot')
    assert page.has_content?('Inactive_drone')
  end

end
