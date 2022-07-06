class ServicesController < ApplicationController
  def index
      parameters = params[:q]
      @q = Item.ransack(parameters)
      @q.order_active = true
      @q.order_status_in = ['Iniciada', 'Sirviendo']
      @q.status_in = ['Confirmado', 'Preparación'] if @q.status_eq.nil?
      @items = @q.result
  end

  def edit
  end

  def update
  end
end
