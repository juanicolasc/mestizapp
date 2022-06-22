class ItemsController < ApplicationController
  before_action :set_order
  append_before_action :set_item, only: [:edit, :update, :destroy]
  append_before_action do
    unless current_user
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to root_path
    end
  end

  def new
    @item = @order.items.build
  end

  def create
    @item = @order.items.build(item_params)

    if @item.save
      respond_to do |format|
        format.html { redirect_to order_path(@order), notice: "Item creado satisfactoriamente." }
        format.turbo_stream { flash.now[:notice] = "Item creado satisfactoriamente." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      respond_to do |format|
          format.html { redirect_to order_path(@order), notice: "Item actualizado." }
          format.turbo_stream { flash.now[:notice] = "Item actualizado." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Item eliminado." }
      format.turbo_stream { flash.now[:notice] = "Item eliminado..." }
    end
  end

  private

    def set_order
        @order = Order.find(params[:order_id])
    end

    def set_item
      @item = @order.items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:product_id, :quantity, :observations)
    end

end
