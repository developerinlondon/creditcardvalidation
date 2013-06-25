load './credit_card.rb'
puts "Type q then Enter to quit. Please input the credit card number:"

input = nil
while true
  input = gets
  digits = input.gsub('\n','')
  c = CreditCard.new(digits)
  break if input == "q\n"
  puts "#{c.get_type}: #{c.number} (#{c.validity})"
end