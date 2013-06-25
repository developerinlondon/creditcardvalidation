load './credit_card.rb'

require 'test/unit'

class CreditCardTest < Test::Unit::TestCase
  def test_initialize
    c1 = CreditCard.new(123456789)
    assert_equal c1.number, "123456789"

    c2 = CreditCard.new("123456789")
    assert_equal c2.number, "123456789"

    c3 = CreditCard.new("1 2345 6789")
    assert_equal c3.number, "123456789"
  end

  def test_non_digits
    c1 = CreditCard.new('123456789')
    assert_equal c1.contain_non_digit?, false

    c2 = CreditCard.new("123456a789")
    assert_equal c2.contain_non_digit?, true

    c3 = CreditCard.new("1 2345 6789")
    assert_equal c3.contain_non_digit?, false

    c4 = CreditCard.new("1 2345 %*.6789")
    assert_equal c4.contain_non_digit?, true
  end

  def test_check_card_type
    c1 = CreditCard.new(4111111111111111)
    assert_equal c1.get_type, "VISA"

    c2 = CreditCard.new(4012888888881881)
    assert_equal c2.get_type, "VISA"

    c3 = CreditCard.new(4111111111111)
    assert_equal c3.get_type, "VISA"

    c4 = CreditCard.new(6011111111111117)
    assert_equal c4.get_type, "Discover"

    c5 = CreditCard.new(5105105105105106)
    assert_equal c5.get_type, "MasterCard"

    c6 = CreditCard.new(9111111111111111)
    assert_equal c6.get_type, "Unknown"

    c7 = CreditCard.new(378282246310005)
    assert_equal c7.get_type, "AMEX"
  end

  def test_luhn_algorithm_validated
    c1 = CreditCard.new(4111111111111111)
    assert_equal c1.luhn_algorithm_validated?, true

    c2 = CreditCard.new(4012888888881881)
    assert_equal c2.luhn_algorithm_validated?, true

    c3 = CreditCard.new(4111111111111)
    assert_equal c3.luhn_algorithm_validated?, false

    c4 = CreditCard.new(6011111111111117)
    assert_equal c4.luhn_algorithm_validated?, true

    c5 = CreditCard.new(5105105105105106)
    assert_equal c5.luhn_algorithm_validated?, false

    c6 = CreditCard.new(9111111111111111)
    assert_equal c6.luhn_algorithm_validated?, false

    c7 = CreditCard.new(378282246310005)
    assert_equal c7.luhn_algorithm_validated?, true
  end

  def test_validity
    c1 = CreditCard.new(4111111111111111)
    assert_equal c1.validity, "valid"

    c2 = CreditCard.new(4012888888881881)
    assert_equal c2.validity, "valid"

    c3 = CreditCard.new(4111111111111)
    assert_equal c3.validity, "invalid"

    c4 = CreditCard.new(6011111111111117)
    assert_equal c4.validity, "valid"

    c5 = CreditCard.new(5105105105105106)
    assert_equal c5.validity, "invalid"

    c6 = CreditCard.new(9111111111111111)
    assert_equal c6.validity, "invalid"

    c7 = CreditCard.new(378282246310005)
    assert_equal c7.validity, "valid"
  end
end