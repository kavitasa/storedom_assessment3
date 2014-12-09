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
    Item.create(name: "Silly", active: true)
    Item.create(name: "Goose")
    visit '/'
    assert page.has_content?("Silly")
    refute page.has_content?("Goose")
  end

  def test_it_displays_active_and_inactive_items
    Item.create(name: "Silly", active: true)
    Item.create(name: "Goose")
    visit '/?show_inactive=true'
    assert page.has_content?("Silly")
    assert page.has_content?("Goose")
  end

  def test_it_has_activate_button
    inactive_item = Item.create(name: "Goose")
    visit '/?show_inactive=true'
    within("div#item_id_#{inactive_item.id}") do
      click_button("Activate!")
    end
    visit '/'
    assert page.has_content?("Goose")
  end

end
