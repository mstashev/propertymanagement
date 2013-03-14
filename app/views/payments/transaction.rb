require 'rubygems'
require 'active_merchant'

# Use the test server
ActiveMerchant::Billing::Base.mode = :test

# Construct a gateway
gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new({
  :login => '5f8Ygta6D4UP',
  :password => '464sH68yF94w8gGR'
})

# Create a credit card
credit_card = ActiveMerchant::Billing::CreditCard.new({
  :first_name => 'Michael',
  :last_name => 'Stashevsky',
  :number => '6011000000000012',
  :month => '10',
  :year => (Time.now.year + 1).to_s,
  :verification_value => '999'
  }
)

#options
options = {
  :billing_address => {
    :name => credit_card.first_name + ' ' + credit_card.last_name,
    :address1 => '1234 Shady Brooke Lane',
    :address2 => 'apt. 48',
    :city => 'Indianapolis',
    :state => 'IN',
    :country => 'US',
    :zip => '46038',
    :phone => '555-555-5555'
  },
  :description => 'Rent Due',
  :invoice => '2093845720938457320987'
}

# Begin purchase
if credit_card.valid?
  response = gateway.purchase(45500, credit_card, options)

  if response.success?
    puts "The transaction was successful. the authorization is #{response.authorization}."
  
  else 
    puts "The transaction was unsuccessful because #{response.message}."
  end
else
  puts "The credit card is invalid."
end