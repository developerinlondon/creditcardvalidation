class CreditCard
  attr_accessor :number, :card_type

  CARD_TYPES = {
    "AMEX" => {
      :begin_with => [34, 37],
      :length     => [15]
    },
    "Discover" => {
      :begin_with => [6011],
      :length     => [16]
    },
    "MasterCard" => {
      :begin_with => [51, 52, 53, 54, 55],
      :length     => [16]
    },
    "VISA" => {
      :begin_with => [4],
      :length     => [13, 16]
    }
  }

  def initialize(digits)
    @number = digits.to_s.gsub(/\s/, '')
    @card_type = ""
    check_card_type
  end

  def check_card_type
    CARD_TYPES.keys.each do |key|
      if CARD_TYPES[key][:length].include? @number.length
        CARD_TYPES[key][:begin_with].each do |digits|
          if @number.start_with?(digits.to_s)
            @card_type = key
            break
          end
        end
      end
      break unless @card_type.length == 0
    end
  end

  def get_type
    @card_type.empty? ? "Unknown" : @card_type
  end

  def validity
    valid? ? "valid" : "invalid"
  end

  def valid?
    !contain_non_digit? &&
    valid_type? &&
    luhn_algorithm_validated?
  end

  def contain_non_digit?
    !@number.match(/[^0-9]/).nil?
  end

  def valid_type?
    @card_type.length != 0
  end

  def luhn_algorithm_validated?
    # 4417 1234 5678 9112:
    # 1 8 4 2 7 2 2 6 4 10 6 14 8 18 1 2 2
    # 2 8+4+2+7+2+2+6+4+1+0+6+1+4+8+1+8+1+2+2 = 69
    # 3 69 % 10 != 0
    reversed_string = @number.reverse
    new_string = ""
    (0..@number.length-1).each do |i|
      if i % 2 == 1
        new_string << (reversed_string[i].to_i * 2).to_s.reverse
      else
        new_string << reversed_string[i]
      end
    end
    sum = 0
    new_string.reverse.each_char do |k|
      sum += k.to_i
    end
    sum % 10 == 0
  end

end