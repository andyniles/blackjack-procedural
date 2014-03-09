#BlackJack game that a user can play
#Written procedurally using Ruby

def calculate_total cards # [['H', '3'], ['S', '5']
  values = cards.map{ |e| e[1] }

  total = 0
  values.each do |value|
    
    if value == "A" #for Aces
      total += 11
    end

    if value.to_i == 0 #for J, K, Q
      total += 10
    else
    
      total += value.to_i
    end

    #correct for Aces
    values.select{|e| e == "A"}.count.times do
      total -= 10 if total > 21
    end

  end

  total
end

puts ">>>> BlackJack! <<<<"

suits = ['H', 'D', 'S', 'C']
card_values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

=begin
alternate method of creating deck array with the suit and value of each card
deck = []
suits.each do |suit|
  card_values.each do |card_value|
    deck << [suit, card_value]
=end

deck = []
deck = suits.product(card_values)
deck.shuffle!

# Deal Cards

my_cards = []
dealer_cards = []

my_cards << deck.pop
dealer_cards << deck.pop

my_cards << deck.pop
dealer_cards << deck.pop

dealer_total = calculate_total(dealer_cards)
my_total = calculate_total(my_cards)

# Display Cards

puts "Dealer has: #{dealer_cards[0]} and #{dealer_cards[1]}, for a total of #{dealer_total}"
puts "You have: #{my_cards[0]} and #{dealer_cards[1]}, for a total of #{my_total}"
puts

# Players turn


if my_total == 21

puts "Congratulations, you hit blackjack! You win!"
exit

end

while my_total < 21
  puts "What would you like to do? 1) hit 2) stay"
  hit_or_stay = gets.chomp

  if !['1', '2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2."
    next
  end

  if hit_or_stay == "2"
    puts "You chose to stay."
    break
  end

  #hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  my_cards << new_card
  my_total = calculate_total(my_cards)
  puts "Your total is now: #{my_total}"

  if my_total == 21
    puts "Congratulations, you hit blackjack! You win!"
    exit
  elsif my_total > 21
    puts "Sorry, you busted!"
    exit
  end
end

# Dealer's turn

if dealer_total == 21
  puts "Sorry, dealer hit blackjack. You lose."
  exit
end

while dealer_total < 17
  #hit
  new_card = deck.pop
  puts "Dealing new card for dealer: #{new_card}"
  dealer_cards << new_card
  dealer_total = calculate_total(dealer_cards)
  puts "Dealer total is now: #{dealer_total}"

  if dealer_total == 21
    puts "Sorry, dealer hit blackjack. You lose."
  elsif dealer_total > 21
    puts "Congratulations, dealer busted! You win!"
    exit
  end
end

# Display both hands

puts "Dealer's cards: "
dealer_cards.each do |card|
  puts "=> #{card}"
end

puts

puts "Your cards:"
my_cards.each do |card|
  puts "=> #{card}"
end
puts

if dealer_total > my_total
  puts "Sorry, dealer wins."
elsif dealer_total < my_total
  puts "Congratulations, you win!"
else
  puts "It's a tie."
end

