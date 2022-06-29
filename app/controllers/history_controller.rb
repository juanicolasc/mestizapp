class HistoryController < ApplicationController
    def index
      @q = Order.ransack(params[:q])
      @pagy, @orders = pagy(@q.result(distinct: true), items: 15)
    end
end
