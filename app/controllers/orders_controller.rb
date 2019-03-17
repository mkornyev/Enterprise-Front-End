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
	end

	def create
		@order = Order.new(order_params)
		@order.date = Time.now.strftime('%m/%d/%y')
		@order.generate_payment_receipt()
		if @order.save
		  #Flash confirmation
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