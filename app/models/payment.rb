class Payment < ActiveRecord::Base
  attr_accessible :amount, :card_expires_on, :first_name, :ip_address, :last_name, :card_number, :verification_value
  attr_accessor :card_number, :verification_value

  validates :amount, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :card_number, :presence => true
  validates :verification_value, :presence => true

 validate :validate_card, :on => :create

  belongs_to :user

  def make_transaction
    response = GATEWAY.purchase((amount*100), credit_card)
    response.success?
  end

  private

  def credit_card
    credit_card = ActiveMerchant::Billing::CreditCard.new({
      :first_name => first_name,
      :last_name => last_name,
      :number => credit_number,
      :month => card_expires_on.month,
      :year => card_expires_on.year,
      :verification_value => verification_value
    })
  end

  def validate_card
    credit_card.errors.full_messages.each do |mesage|
      error.add_to_base message
    end
  end
end