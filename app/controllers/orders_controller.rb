class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  append_before_action do
    unless current_user
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to root_path
    end
  end

  # GET /orders or /orders.json
  def index
    @orders = Order.where(:active => true)
  end

  # GET /orders/1 or /orders/1.json
  def show
    @products = Product.where(:active => true)
    @items = @order.items
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.date = Date.today
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.active = true
    @order.user = current_user

    respond_to do |format|
      if @order.save
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.update(:active => false)

    respond_to do |format|
      format.html { redirect_to order_url(@order), notice: "Se eliminó la orden." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:date, :observations, :total_value, :tax, :tip, :guests, :user_id, :customer_id, :table_id, :aditions)
    end
end
