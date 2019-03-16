class AddressesController < ApplicationController
  
  def index
  	#Setting controller variables and paginating 
    @active_addresses = Address.active.alphabetical.paginate(page: params[:page]).per_page(20)
    @inactive_addresses = Address.inactive.alphabetical.paginate(page: params[:page]).per_page(20)
  end

  def new
    @address = Address.new
  end

  def edit
  end

  def create
    @address = Address.new(address_params)
    if @owner.save
      # if saved to database
      flash[:notice] = "Successfully created #{@owner.proper_name}."
      redirect_to owner_path(@owner) # go to show owner page
    else
      # return to the 'new' form
      render action: 'new'
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