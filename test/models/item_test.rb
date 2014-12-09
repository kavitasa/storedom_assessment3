require_relative '../test_helper'

class ItemTest < ActiveSupport::TestCase

  def test_item_is_created
    Item.create(name: 'Foo', description: 'silly silly silly')
    item = Item.find_by_name('Foo')
    refute item.id.nil?
    refute item.active
  end

end
