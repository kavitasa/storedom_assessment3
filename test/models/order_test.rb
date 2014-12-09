require_relative '../test_helper'

class OrderTest < ActiveSupport::TestCase

  def test_it_can_set_status
    order = Order.create(user_id: 1, amount: 100, status: 'submitted')
    assert order.id
    assert order.valid?
  end

  def test_it_validates_status
    Order::STATUSES.each do |status|
      order = Order.create(user_id: 1, amount: 100, status: status)
      assert order.valid?
    end
    order = Order.create(user_id: 1, amount: 100, status: 'silly')
    assert order.invalid?
  end

  def test_it_groups_orders_by_status
    Order::STATUSES.each do |status|
      Order.create(status: status)
    end
    grouped_orders = Order.group_by_status
    Order::STATUSES.each do |status|
      grouped_orders[status].each do |order|
        assert_equal status, order.status
      end
    end
  end

end
