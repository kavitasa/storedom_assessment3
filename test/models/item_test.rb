require_relative '../test_helper'

class ItemTest < ActiveSupport::TestCase

  def test_it_can_be_active
    item = Item.create(name: "Silly", active: true)
    assert item.active
  end

end
