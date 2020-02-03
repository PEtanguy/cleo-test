require "pry"
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

  def display(items)
    items.each do |item|
      puts "ID:#{item.id}: #{item.name} - £#{item.price} - Remaining:#{item.quantity}

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

  def display_coins
    puts ">Coins Accepted:
    0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2
    ".brown
  end
end
