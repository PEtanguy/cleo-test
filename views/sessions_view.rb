class SessionsView
  def ask_for(label)
    puts "#{label}?".blue
    print "> "
    gets.chomp
  end

  def ask_for_integer(label)
    puts "#{label}?".blue
    print "> "
    gets.chomp.
  def wrong_credentials
    puts "Wrong credentials, try again

    ".red
  end
end

