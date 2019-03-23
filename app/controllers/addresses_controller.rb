class AddressesController < ApplicationController
  #Callback 
  before_action :set_address, only: [:show, :edit, :update]

  #Restful methods: 
  def index
  	#Setting controller variables and paginating 
    @active_addresses = Address.active.by_customer.paginate(page: params[:page]).per_page(20)
    @inactive_addresses = Address.inactive.by_customer.paginate(page: params[:page]).per_page(20)
  end

  def show
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      #Confirmation Flash
      @customer = Customer.find(@address.customer_id) #Set a single address owner 
      flash[:notice] = "The address was added to #{@customer.proper_name}."
      redirect_to customer_path(@customer) 
    else
      #Redirect to create another addy
      render action: 'new'
    end
  end

  def update
  	#Confirmation flash
    if @address.update_attributes(address_params) 
      flash[:notice] = "The address was updated."
      redirect_to addresses_path
    else
      #Redirect to edit again
      render action: 'edit'
    end
  end

  #Private Whitelist and Set methods 
  private
  def set_address
    @address = Address.find(params[:id])
  end
  #Whitelisted params
  def address_params
    params.require(:address).permit(:customer_id, :is_billing, :recipient, :street_1, :city, :state, :zip, :active)
  end

end