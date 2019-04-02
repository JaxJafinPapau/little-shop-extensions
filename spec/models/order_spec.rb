require "rails_helper"

RSpec.describe Order, type: :model do
  describe "Relationships" do
    it {should have_many :order_items}
    it {should have_many :items}
  end
end
