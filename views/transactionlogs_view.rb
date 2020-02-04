class TransactionlogsView
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

  def display(transactions)
    transactions.each do |t|
      puts "
      ----------------------------------------------------------------------
     |  Transaction ID:       #{t.id}
     |  Quantity purchased:   #{t.quantity}
     |  Total: £              #{t.total_price}
     |  Transaction made on:  #{t.datetime}
     |
       ---------------------------------------------------------------------".brown
    end
  end
end
