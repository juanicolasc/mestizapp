class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show edit update destroy ]
  append_before_action do
    unless current_user
      flash[:alert] = 'No tiene permiso para esta acción'
      redirect_to root_path
    end
  end

  # GET /customers or /customers.json
  def index
      parameters ||= params[:q]
      if parameters and (parameters.is_a? String)
        parameters = {:name_or_identification_or_email_cont=>params[:q]}
        auto_complete = true
      end
      @query = Customer.ransack(parameters)
      total_list = @query.result
      @pagy, @customers = pagy(total_list, items: 15)
      if auto_complete
          render partial: 'searching', formats: :html
      end
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      respond_to do |format|
        format.html { redirect_to customer_url(@customer), notice: "Ciente creado satisfactoriamente." }
        format.turbo_stream {  flash.now[:notice] = "Ciente creado satisfactoriamente.."}
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    if @customer.update(customer_params)
      respond_to do |format|
          format.html { redirect_to customer_url(@customer), notice: "Ciente actualizado." }
          format.turbo_stream { flash.now[:notice] = "Ciente actualizado." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:name, :identification, :email)
    end
end
