class Customer < ApplicationRecord

  # Relationships
  has_many :orders
  has_many :addresses

  # Scopes
  scope :alphabetical,  -> { order(:last_name).order(:first_name) }
  scope :active,        -> { where(active: true) }
  scope :inactive,      -> { where(active: false) }

  # Validations
  validates_presence_of :last_name, :first_name
  validates_format_of :phone, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, message: "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"


  # Callbacks
  before_save :reformat_phone

  # Other methods
  def name
    "#{last_name}, #{first_name}"
  end

  def proper_name
    "#{first_name} #{last_name}"
  end

  # Private methods
  private
  def reformat_phone
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end

end
