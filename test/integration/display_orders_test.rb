require_relative '../test_helper'

class DisplaysOrdersTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_displays_orders_grouped_by_status
    user = User.create(name: 'Person')
    orders = Order::STATUSES.map do |status|
      Order.create(user: user, status: status)
    end
    visit '/orders'
    orders.each do |order|
      within("div##{order.status}") do
        assert page.has_css?("div[data-order-id='#{order.id}']")
      end
      submitted_order = orders.detect { |order| order.status == "submitted" }
      within("div#rejected") do
        refute page.has_css?("div[data-order-id='#{submitted_order.id}']")
      end
    end
  end

  def test_it_updates_order_status
    user = User.create(name: 'Person')
    order = Order.create(user_id: user.id, status: 'submitted')
    visit '/orders'
    within("div[data-order-id='#{order.id}']") do
      assert page.has_css?("select", "submitted")
      select 'rejected', from: "status"
      click_button 'Save'
    end
    visit '/'
    within("div#rejected") do
      assert page.has_css?("div[data-order-id='#{order.id}']")
    end
    within("div[data-order-id='#{order.id}']") do
      assert page.has_css?("select", "rejected")
    end
  end

end
