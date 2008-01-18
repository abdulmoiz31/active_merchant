require File.dirname(__FILE__) + '/../../test_helper'

class SecurePayTechTest < Test::Unit::TestCase
  AMOUNT = 100

  def setup
    @gateway = SecurePayTechGateway.new(
                 :login => 'x',
                 :password => 'y'
               )

    @creditcard = credit_card('4987654321098769')

    @address = { :address1 => '1234 My Street',
                 :address2 => 'Apt 1',
                 :company => 'Widgets Inc',
                 :city => 'Ottawa',
                 :state => 'ON',
                 :zip => 'K1C2N6',
                 :country => 'Canada',
                 :phone => '(555)555-5555'
               }
  end
  
  def test_successful_request
    @creditcard.number = 1
    assert response = @gateway.purchase(AMOUNT, @creditcard, {})
    assert_success response
    assert_equal '5555', response.authorization
    assert response.test?
  end

  def test_unsuccessful_request
    @creditcard.number = 2
    assert response = @gateway.purchase(AMOUNT, @creditcard, {})
    assert_failure response
    assert response.test?
  end
end
