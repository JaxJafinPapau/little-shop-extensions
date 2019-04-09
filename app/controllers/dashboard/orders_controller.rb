class Dashboard::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @item = Item.find(params[:item_id])
    @order.order_items.where(item_id: @item).first.update(fulfilled: true)
    @item.update_inventory(@order)
    redirect_to dashboard_order_path(@order), success: "You have fulfilled #{@item.item_name}"
  end

end
