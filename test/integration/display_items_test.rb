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

  def test_it_only_displays_active_items
    Item.create(name: 'Inactive_robot')
    Item.create(name: 'Active_drone', active: true)
    visit '/'

    within("#robots-list") do
      assert page.has_content?('Active_drone')
      refute page.has_content?('Inactive_robot'), 'Should show only active robots'
    end
  end

  def test_it_shows_inactive_items_with_inactive_params
    Item.create(name: 'Inactive_robot')
    Item.create(name: 'Active_drone', active: true)
    visit '/?show_inactive=true'
    within("#robots-list") do
      assert page.has_content?('Active_drone')
      assert page.has_content?('Inactive_robot'), 'Should show inactive robots'
    end
    visit '/?show_inactive=false'
    within("#robots-list") do
      assert page.has_content?('Active_drone')
      refute page.has_content?('Inactive_robot'), 'Should only show active robots'
    end
  end

  def test_it_activates_inactive_item
    inactive_item = Item.create(name: 'Inactive_robot')
    active_item = Item.create(name: 'Active_drone', active: true)
    visit '/?show_inactive=true'
    within("div#Item_#{inactive_item.id}") do
      assert page.has_button?('Activate!')
    end
    within("div#Item_#{active_item.id}") do
      refute page.has_button?('Activate!')
    end
  end

end
