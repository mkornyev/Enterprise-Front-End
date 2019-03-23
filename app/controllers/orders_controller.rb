require 'Date' #Impossible to set a date value using just the Time Class

class OrdersController < ApplicationController
	#Controller callbacks to set Order instance 
	before_action :set_order, only: [:show, :edit, :update]

	#Restful methods: 
	def index
	  #Finding all orders chronologically, and paginating 
	  @all_orders = Order.all.order('date DESC').paginate(page: params[:page]).per_page(20)
	end

	def show
	  #Find all orders by same recipient, recent orders first
	  @previous_orders = Order.for_customer(@order.customer_id).order('date DESC')
	end 

	def new
	  @order = Order.new
	  #Create an address array for easy collection access in the Order form (Not breaking MVC!)
	  @addresses_collection = [] 
	  Address.active.each do |add| 
	  	@addresses_collection << (add.street_1 + ", " + add.city + ", " + add.state + " " + add.zip).to_s
	  end
	end

	def create
		@order = Order.new(order_params)
		@order.date = Date.today #THERE IS SOMETHING WRONG WITH THIS THE DATE VAR BUT I CANNOT FIND A SOLUTION (Date.current/Time.now does not work)
		if @order.save
		    #Flash confirmation
		    @order.generate_payment_receipt() #Generate the receipt upon save
			flash[:notice] = "Thank you for ordering from the Baking Factory."
			redirect_to order_path(@order) # go to show owner page
		else
			#Redirect to new template
			render action: 'new'
		end
	end

	#Private set and whitelist methods 
	private 
	def set_order
		@order = Order.find(params[:id])
	end

	def order_params
		params.require(:order).permit(:date, :customer_id, :address_id, :grand_total)
	end
end