require_relative '../test_helper'

class ItemTest < ActiveSupport::TestCase

  def test_it_defaults_to_active_false
    item = Item.create(name: 'Inactive_drone')
    refute item.active
  end

  def test_active_shows_active_records
    active_item = Item.create(name: 'Active_robot', active: true)
    inactive_item = Item.create(name: 'Inactive_drone')
    assert_equal Item.active.map(&:id), [active_item.id]
  end

end
