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
    @balance = 0
  end

  def list
    items = @item_repository.all
    @view.display(items)
  end

  def add
    @employee = @sessions_controller.sign_in
    name = @view.ask_for("name of the item")
    price = @view.ask_for_integer(:price)
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
      price = @view.ask_for("price").to_i
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
    @balance += input_certified
  end

  def enter_coins
    @view.display_coins
    coin = @view.ask_for_integer("which coin?")
    @coin_options = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2]
    if @coin_options.include?(coin)
      increment_balance(coin)
    else
      puts 'input not accepted.'
    end
  end

  def purchase_item
    list
    item = @view.ask_for("ID of the item").to_i
    quantity = @view.ask_for("How many do you want to purchase").to_i
    item = @item_repository.find(item)
    total_price = (item.price * quantity)
    change = @balance - total_price
    if change >= 0 && item.quantity >= quantity
      transaction = Transactionlog.new(item_quantity: quantity, total_price: total_price, item_id: item.id, datetime: Time.now)
      @transactionlog_repository.add(transaction)
      @balance -= total_price
      item.quantity -= quantity
      @item_repository.write_csv
      puts "success! Enjoy your #{item.name}!

      ".cyan

    else
      puts "transaction impossible.
      ".red
    end
  end
end
