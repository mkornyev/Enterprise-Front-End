module Populator
  module Orders
    def create_orders_for(customers)
      customers.each do |customer|
        c_address_ids = customer.addresses.map(&:id)
        [1,1,1,2,2,2,2,3,3,3,3,4,4,5,6,7,9,10,12].sample.times do |i|
          order = Order.new
          order.customer_id = customer.id
          order.address_id = c_address_ids.sample
          order.date = (5.months.ago.to_date..2.days.ago.to_date).to_a.sample
          order.save!
          total = 0
          
          # record total and payment
          total = 12.53
          order.update_attribute(:grand_total, total)
          order.pay
        end
      end

    end
  end
end