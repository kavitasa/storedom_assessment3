require_relative '../test_helper'

class DisplaysOrdersTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_reaches_the_root_page
    visit '/orders'
    assert_equal 200, page.status_code

    within('h1') do
      assert page.has_content?('Orders'), "page should have an Orders heading"
    end
  end

  def test_it_shows_orders
    user = User.create(name: 'daffy duck')
    Order.create(user_id: user.id)
    visit '/orders'
    assert page.has_content?('daffy duck')
  end

  def test_it_has_a_status
    user = User.create(name: 'daffy duck')
    Order.create(user_id: user.id, status: 'completed')
    visit '/orders'
    save_and_open_page
    assert page.has_content?('completed')
  end

  def test_slick_users_can_view_active_and_inactive_items
    skip
    Item.create(name: 'active_robot', active: true)
    Item.create(name: 'inactive_drone', active: false)
    visit '/?show_inactive=true'
    assert page.has_content?('active_robot')
    assert page.has_content?('inactive_drone')
  end

  def test_only_inactive_items_have_active_button
    skip
    Item.create(name: 'active_robot', active: true)
    Item.create(name: 'inactive_drone', active: false)
    visit '/?show_inactive=true'
    within '.item_name', text: 'active_robot' do
      refute page.has_button?('Activate')
    end
    within '.item_name', text: 'inactive_drone' do
      assert page.has_button?('Activate')
    end
  end

  def test_clicking_activate_sets_inactive_item_to_active
    skip
    Item.create(name: 'inactive_drone', active: false)
    visit '/?show_inactive=true'
    click_on('Activate')
    assert page.has_content?('inactive_drone')
  end

end
