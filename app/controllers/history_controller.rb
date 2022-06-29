class HistoryController < ApplicationController
  append_before_action do
    unless current_user && current_user.admin?
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to root_path
    end
  end


  def index
      parameters = params[:q]
      @q = Order.ransack(parameters)
      if @q.active_eq.nil?
         @q.active_eq = true
      end
      if @q.date_gteq.nil?
         @q.date_gteq = Date.today-(1.days)
         @q.date_lteq = Date.today
      end
      total_list = @q.result
      @total_value_sum = total_list.sum(:total_value)
      @total_aditions_sum  = total_list.sum(:aditions)
      @total_tip_sum = total_list.sum(:tip)
      @total_final_value_sum = total_list.sum(:final_value)
      @pagy, @orders = pagy(total_list, items: 15)
  end
end
