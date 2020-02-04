class ItemsView
  def ask_for(label)
    puts "#{label}?".blue
    print "> "
    gets.chomp
  end

  def ask_for_integer(label)
    puts "#{label}?".blue
    print "> "
    gets.chomp.to_i
  end

  def coin_options(action)
    case action
    when 1 then return 1
    when 2 then return 2
    when 3 then return 5
    when 4 then return 10
    when 5 then return 20
    when 6 then return 50
    when 7 then return 100
    when 8 then return 200
    else puts "Coin not Accepted!

      ".red
    end
  end

  def ask_for_coin(label)
    puts "Coins accepted: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2".blue
    puts "1. 1p".green
    puts "2. 2p".green
    puts "3. 5p".green
    puts "4. 10p".green
    puts "5. 20p".green
    puts "6. 50p".green
    puts "7. £1".green
    puts "8. £2".green



    coin = gets.chomp.to_i
    coin_options(coin)
  end

  def ask_for_float(label)
    puts "#{label}?".blue
    print "> "
    gets.chomp.to_f
  end

  def display(items)
    items.each do |item|
      puts "
      ID:#{item.id}: #{item.name} - £#{sprintf('%.2f', item.price/100.00)} - Remaining:#{item.quantity}

      ".brown
    end
  end

  def display_item_properties(item)
    puts "
    Refill or Change the price:

    1- Price: #{item.price}
    2- Quantity: #{item.quantity}

    "
    print "> "
    gets.chomp.to_i
  end
end
