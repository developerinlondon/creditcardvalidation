How To Run The Program
========
1. Install ruby (Mac OS user already have ruby installed)
2. Open terminal
3. run `ruby program.rb`
4. You need to input any digits string, the the program will check if the credit number is valid or not. Type 'q' to quit.

How To Run The Test
========

1. Open terminal
2. run `ruby test.rb`

What the test is about:
========
  - The credit card number should taken from input, not contain any space character
 
  ```
  def test_initialize
    c1 = CreditCard.new(123456789)
    assert_equal c1.number, "123456789"
  end
  ```

  - The credit card Should not contain any non-digit character in credit card number
  
  ```
  def test_non_digits
    c1 = CreditCard.new('123456789')
    assert_equal c1.contain_non_digit?, false

    c2 = CreditCard.new("123456a789")
    assert_equal c2.contain_non_digit?, true
  end
  ```

  
  - Credit card type should be "Unknown" if it not belongs to any type
  
  ```
  def test_check_card_type
    c1 = CreditCard.new(4111111111111111)
    assert_equal c1.get_type, "VISA"

    c6 = CreditCard.new(9111111111111111)
    assert_equal c6.get_type, "Unknown"
  end
  ```

  - Test validity by using Luhn algorithm
  
  ```
  def test_luhn_algorithm_validated
    c1 = CreditCard.new(4111111111111111)
    assert_equal c1.luhn_algorithm_validated?, true

    c3 = CreditCard.new(4111111111111)
    assert_equal c3.luhn_algorithm_validated?, false
  end
  ```

  - A credit card can must have valid type & valididated by luhn algorithm
  
  ```
  def test_validity
    
  c1 = CreditCard.new(4111111111111111)
    assert_equal c1.validity, "valid"

    c6 = CreditCard.new(9111111111111111)
    assert_equal c6.validity, "invalid"
  end
  ```
  
