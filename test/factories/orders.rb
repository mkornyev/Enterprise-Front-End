FactoryBot.define do
  factory :order do
    date Date.current
    association :customer
    association :address
    grand_total 0.00
    payment_receipt nil
  end
end
