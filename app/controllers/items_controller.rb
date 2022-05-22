class ItemsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @item = @order.items.create(item_params)
    redirect_to order_path(@order)
  end

  private
    def item_params
      params.require(:item).permit(:product_id, :quantity, :observations)
    end
end
