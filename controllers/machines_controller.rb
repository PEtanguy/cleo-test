require_relative "../models/item.rb"
require_relative "../repositories/item_repository.rb"
require_relative "../models/transactionlog.rb"
require_relative "../views/items_view.rb"

class MachinesController
  attr_accessor :balance

  def initialize(item_repository, transactionlog_repository, sessions_controller)
    @item_repository = item_repository
    @sessions_controller = sessions_controller
    @transactionlog_repository = transactionlog_repository
    @view = ItemsView.new
    @balance = 0.00
  end

  def balance
    @balance
  end

  def list
    items = @item_repository.all
    @view.display(items)
  end

  def add
    @employee = @sessions_controller.sign_in
    name = @view.ask_for("name of the item")
    price = @view.ask_for_float("price, in £") * 100
    quantity = @view.ask_for_integer(:quantity)
    new_item = Item.new(name: name, price: price, quantity: quantity)
    @item_repository.add(new_item)
  end

  def refill
    @employee = @sessions_controller.sign_in
    list
    item = @view.ask_for(:id).to_i
    item = @item_repository.find(item)
    change = @view.display_item_properties(item)
    if change == 1
      price = @view.ask_for("price").to_f * 100.00
      item.price = price
      @item_repository.find(item.id).price = price
      @item_repository.write_csv

    elsif change == 2
      quantity = @view.ask_for("quantity").to_i
      item.quantity = quantity
      # @item_repository.add(item)
      @item_repository.find(item.id).quantity = quantity
      @item_repository.write_csv
    else
      puts "Invalid Command
      ".red
    end
  end

  def display_balance
    @balance
  end

  def increment_balance(input_certified)
    @balance += input_certified/100.00
  end

  def enter_coins
    coin = @view.ask_for_coin("which coin?")
    increment_balance(coin)
  end

  def change_compute(amount)
    available_coins = [200 ,100 ,50 ,20 ,10 ,5 ,2 ,1]
    coins = []
    index = 0
    coin = available_coins[index]
    remaining_amount = amount
    until remaining_amount.zero?
      until remaining_amount >= coin
         index += 1
         coin = available_coins[index]
      end
      coins << coin
      remaining_amount -= coin
    end
    coins
  end


  def purchase_item
    list
    item = @view.ask_for("ID of the item").to_i
    quantity = @view.ask_for("How many do you want to purchase").to_i
    item = @item_repository.find(item)
    total_price = (item.price * quantity)
    change_float = ((@balance*100) - total_price).ceil


    if change_float >= 0 && item.quantity >= quantity
      change_array = change_compute(change_float)
      change_counts = Hash.new(0)
      change_array.each { |change| change_counts[change] += 1 }
      transaction = Transactionlog.new(item_quantity: quantity, total_price: total_price, item_id: item.id, datetime: Time.now)
      @transactionlog_repository.add(transaction)
      @balance -= total_price
      item.quantity -= quantity
      @item_repository.write_csv
      puts "success! Enjoy your #{item.name}!
      ".cyan
    puts "
      -------------------------------------------
      Here is your change:
      ".cyan
      change_counts.each do |coin, value|
        if coin == 200
            puts "          #{value} x £2".cyan
        elsif coin == 100
            puts "          #{value} x £1".cyan
        elsif coin == 50
            puts "          #{value} x 50p".cyan
        elsif coin == 20
            puts "          #{value} x 20p".cyan
        elsif coin == 10
            puts "          #{value} x 20p".cyan
        elsif coin == 5
            puts "          #{value} x 5p".cyan
        elsif coin == 2
            puts "          #{value} x 2p".cyan
        elsif coin == 1
            puts "          #{value} x 1p".cyan
        end
      end
      @balance = 0
    else
      puts "transaction impossible.
      ".red
    end
  end
end
