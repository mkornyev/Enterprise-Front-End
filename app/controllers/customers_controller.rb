class CustomersController < ApplicationController
  # Callback to set up customer object
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    #Finding active/inactive customers, and paginating 
    @active_customers = Customer.active.alphabetical.paginate(page: params[:page]).per_page(20)
    @inactive_customers = Customer.inactive.alphabetical.paginate(page: params[:page]).per_page(20)
  end

  def show
  	@previous_orders = @customer.joins(:orders).order("date DESC").to_a
  end

  def new 
  	@customer = Customer.new 
  end

  def edit 
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      #Flash confirmation
      flash[:notice] = "#{@customer.proper_name} was added to the system."
      #Show newest customer
      redirect_to customer_path(@customer) 
    else
      #Else redirect to New
      render action: 'new'
    end 
  end

  def update
  	if @customer.update_attributes(owner_params) 
      flash[:notice] = "#{@owner.proper_name} was sucessfully updated."
      redirect_to @customer
    else
      render action: 'edit'
    end
  end

  def destroy
  end

  private
  def set_customer
	@customer = Customer.find(params[:id])  	
  end
  #Whitelisted params
  def customer_params
  	params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active)
  end

end
