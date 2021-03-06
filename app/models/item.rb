class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :discounts

  validates :inventory, numericality: { greater_than_or_equal_to: 0 }
  validates :current_price, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0 }

  def self.popular_five
    joins(:order_items).where("order_items.fulfilled": true, enabled: true).select("items.*, sum(order_items.quantity) as total").group(:id).order("total desc").limit(5)
  end

  def self.unpopular_five
    unpopular = []
    oi_item_ids = OrderItem.select(:item_id).distinct.pluck(:item_id)
    unpopular << Item.where.not(id: oi_item_ids).limit(5)
    unpopular << joins(:order_items).where("order_items.fulfilled": true).select("items.*, sum(order_items.quantity) as total").group(:id).order("total asc")
    unpopular.flatten![0..4]
  end

  def self.merchant_items(merchant)
    all.where(id: [merchant.items.pluck(:id)])
  end

  def merchant_name
    User.where(id: self.user_id).first.name
  end

  def avg_fulfill_time
    if OrderItem.where(item_id: self.id, "order_items.fulfilled": true).first
      OrderItem.where(item_id: self.id, "order_items.fulfilled": true).group(:item_id).pluck("AVG(updated_at - created_at)")
    else
      "no shipments yet"
    end
  end

  def quantity_sold
    order_items.where(fulfilled: true).sum(:quantity)
  end

  def subtotal(order)
    order_items.where(order_id: order.id).sum("quantity*order_price")
  end

  def order_price(order)
    order_items.where(order_id: order.id).first.order_price
  end

  def order_quantity(order)
    # OrderItem.where(item_id: self, order_id: order.id).first.quantity
    order_items.where(order_id: order.id).first.quantity
  end

  def update_inventory(order)
    new_inventory = self.inventory - order.order_items.where(item_id: self.id).first.quantity
    update(inventory: new_inventory)
  end

  def max_eligible_discount(quantity)
    discounts.max do |discount|
      quantity <=> discount.min_quantity
    end
  end

  def qualify_for_discount?(quantity)
    discounts.any? && quantity >= discounts.minimum(:min_quantity)
  end

  def calculation_percentage(quantity)
    1 - self.max_eligible_discount(quantity).percentage
  end
end
