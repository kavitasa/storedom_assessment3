class Order < ActiveRecord::Base

  STATUSES = ['submitted', 'paid', 'rejected', 'complete']

  validates :status, inclusion: { in: STATUSES }

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  def self.group_by_status
    all.group_by(&:status)
  end

end
