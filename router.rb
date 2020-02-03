require_relative "string_override.rb"

class Router
  def initialize(machines_controller, transactionlogs_controller)
    @machines_controller = machines_controller
    @transactionlogs_controller = transactionlogs_controller
    @running = true
  end

  def run

      print_actions_cool
      sleep(2)
    while @running
      print_actions
      action = ask_action
      route_action(action)
    end
  end

  private
  def print_actions_cool
    puts "
 ____________________________________________
|############################################|
|#|                           |##############|
|#|  =====  ..--''`  |~~``|   |##|````````|##|
|#|  |   |  \\     |  :    |   |##| Exact  |##|
|#|  |___|   /___ |  | ___|   |##| Change |##|
|#|  /=__\\  ./.__\\   |/,__\\   |##| Only   |##|
|#|  \\__//   \\__//    \\__//   |##|________|##|
|#|===========================|##############|
|#|```````````````````````````|##############|
|#| =.._      +++     //////  |##############|
|#| \\/  \\     | |     \\    \\  |#|`````````|##|
|#|  \\___\\    |_|     /___ /  |#| _______ |##|
|#|  / __\\\\  /|_|\\   // __\\   |#| |1|2|3| |##|
|#|  \\__//-  \\|_//   -\\__//   |#| |4|5|6| |##|
|#|===========================|#| |7|8|9| |##|
|#|```````````````````````````|#| ``````` |##|
|#| ..--    ______   .--._.   |#|[=======]|##|
|#| \\   \\   |    |   |    |   |#|  _   _  |##|
|#|  \\___\\  : ___:   | ___|   |#| ||| ( ) |##|
|#|  / __\\  |/ __\\   // __\\   |#| |||  `  |##|
|#|  \\__//   \\__//  /_\\__//   |#|  ~      |##|
|#|===========================|#|_________|##|
|#|```````````````````````````|##############|
|############################################|
|#|||||||||||||||||||||||||||||####```````###|
|#||||||||||||PUSH|||||||||||||####\\|||||/###|
|############################################|
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\///////////////////////
 |________________________________|____|___|
".cyan
  end

  def print_actions
    puts "

    Balance: £#{@machines_controller.balance}".bold.bg_green
    puts "
    "
    puts "1. List all items".green
    puts "2. Purchase item".green
    puts "3. Insert coins

    ".green
    puts "ADMIN OPTIONS".bold.bg_magenta.underline
    puts "
    Hint:
    Email: pierre@cleo.com
    Password: secret
    "
    puts "4. Add new items in the machine".magenta
    puts "5. Refill Machine".magenta
    puts "6. See transactions log

    ".magenta

    puts "7. Exit

    ".red
  end

  def route_action(action)
    case action
    when 1 then @machines_controller.list
    when 2 then @machines_controller.purchase_item
    when 3 then @machines_controller.enter_coins
    when 4 then @machines_controller.add
    when 5 then @machines_controller.refill
    when 6 then @transactionlogs_controller.display_logs

    when 7 then @running = false
    else puts "Wrong action

      ".red
    end
  end

  def ask_action
    puts "

    What do you want to do next?
      ".magenta
    print "> "
    gets.chomp.to_i
  end
end
