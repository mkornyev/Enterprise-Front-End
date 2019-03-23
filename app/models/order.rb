class Order < ApplicationRecord
  require 'base64'

  # Relationships
  belongs_to :customer
  belongs_to :address

  # Scopes
  scope :chronological, -> { order(date: :desc) }
  scope :paid,          -> { where.not(payment_receipt: nil) }
  scope :for_customer,  ->(customer_id) { where(customer_id: customer_id) }

  # Validations
  validates_date :date
  validates_numericality_of :grand_total, greater_than_or_equal_to: 0, allow_blank: true
  validate :customer_is_active_in_system
  validate :address_is_active_in_system

  # Other methods
  def pay
    return false unless self.payment_receipt.nil?
    generate_payment_receipt
    self.save!
    self.payment_receipt
  end

  def generate_payment_receipt
    self.payment_receipt = Base64.encode64("order: #{self.id}; amount_paid: #{self.grand_total}; received: #{self.date}")
    self.save!
  end

  private
  def customer_is_active_in_system
    all_customer_ids = Customer.active.map(&:id)
    unless all_customer_ids.include?(self.customer_id)
      errors.add(:customer, "is not an active customer in the system")
    end
  end

  def address_is_active_in_system
    all_address_ids = Address.active.map(&:id)
    unless all_address_ids.include?(self.address_id)
      errors.add(:address, "is not an active address in the system")
    end
  end

end
