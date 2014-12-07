class Order < ActiveRecord::Base
  STATUSES = ["submitted", "paid", "rejected", "complete"]

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  validates :status, inclusion: { in: STATUSES, message: "%{value} is not a valid order status" }

  def self.group_by_status
    all.group_by(&:status)
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to orders_path, notice: "Order successfully updated"
  end

  private
  def order_params
    params.require(:order).permit(:status)
  end
end
