require_relative '../test_helper'

class DisplaysItemsTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_reaches_the_root_page
    visit '/'
    assert_equal 200, page.status_code

    within('h1') do
      assert page.has_content?('Items'), "page should have an Items heading"
    end
  end

  def test_it_shows_active_items
    Item.create(name: 'silly', description: 'goose goose goose goose goose goose goose goose')
    visit '/'
    assert page.has_content?('silly')
    assert page.has_content?('goose')
  end

  def test_it_does_not_show_inactive_items
    Item.create(name: 'silly', description: 'goose goose goose goose goose goose goose goose', active: false)
    visit '/'
    refute page.has_content?('silly')
    refute page.has_content?('goose')
  end

  def test_slick_users_can_view_active_and_inactive_items
    Item.create(name: 'active_robot', active: true)
    Item.create(name: 'inactive_drone', active: false)
    visit '/?show_inactive=true'
    assert page.has_content?('active_robot')
    assert page.has_content?('inactive_drone')
  end

  def test_only_inactive_items_have_active_button
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
    Item.create(name: 'inactive_drone', active: false)
    visit '/?show_inactive=true'
    click_on('Activate')
    assert page.has_content?('inactive_drone')
  end

end
