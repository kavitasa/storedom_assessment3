class Order < ActiveRecord::Base
  STATUSES = ["submitted", "paid", "rejected", "complete"]

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  validates :status, inclusion: { in: STATUSES, message: "%{value} is not a valid order status" }

  def self.group_by_status
    all.group_by(&:status)
  end
end
