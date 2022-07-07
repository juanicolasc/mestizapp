class ServicesController < ApplicationController
  before_action :set_item, only: [:update]

  def index
      parameters = params[:q]
      @q = Item.ransack(parameters)
      @q.order_active = true
      @q.order_status_in = ['Iniciada', 'Sirviendo']
      @q.status_in = ['Confirmado', 'Preparación'] if @q.status_eq.nil?
      @q.sorts = ['created_at asc', 'updated_at asc']
      @items = @q.result
      @orders = @items.map(&:order).uniq

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


  private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:status)
    end
end
