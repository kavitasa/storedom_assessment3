require_relative '../test_helper'

class ItemsControllerTest < ActionController::TestCase

  def test_it_shows_inactive_items
    Item.create(name: "Silly", active: true)
    Item.create(name: "Goose")
    get :index
    assert_equal 1, assigns(:items).count
    get(:index, { show_inactive: true })
    assert_equal 2, assigns(:items).count
  end

end
