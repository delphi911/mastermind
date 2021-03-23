local_dir = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(local_dir)
require "controller.rb"
require "interface.rb"
require "code.rb"
require "ai.rb"

class GameMastermind
  MAXTRIES = 12
  def initialize
    @interface = Interface.new
    @controller = Controller.new  
    @action = nil
    @feedback = nil
    @guess = nil
    @controller.startinggame
  end

  def play
    while @action != :quit
      get_action
      handle_action
      mainloophumanplayer if @action == :play
      mainloopAiplayer if @action == :ai
      suggestasecretcode if @action == :suggest
    end
  end

  def mainloophumanplayer
    code = SecretCode.new
    (1..MAXTRIES).each do |turn|
      puts "Turn : #{turn}"
      resultA = code.guessResult(getmove)
      p resultA
      if resultA[0] == SecretCode::CODE_LENGTH
        puts "player wins in #{turn} attempts!"
        return
      end
      end #loop
      puts "Player failed to guess the code in #{MAXTRIES} attempts..."
  end

  def mainloopAiplayer
    ai = Ai.new
    (1..MAXTRIES).each do |turn|
      puts "Turn : #{turn}"
      puts "My guess is : #{ai.makeaguess(ai.aiguess,@feedback)}"
      @feedback = getfeedback
      if @feedback[0] == SecretCode::CODE_LENGTH
         puts "player wins in #{turn} attempts!"
         return
      end
    end #loop
    puts "Player failed to guess the code in #{MAXTRIES} attempts..."
  end

  def suggestasecretcode
    puts SecretCode.new.printcode.join
  end

  private

  def get_action
    @action = @interface.get_action
  end

  def handle_action
    @controller.send @action
  end

  def getmove
    moveinput
    while ((@guess - SecretCode::COLOR).count > 0) || (@guess.count != 4) do
        puts "You did not enter a valid move."
        moveinput
    end
    @guess
  end
  
  def moveinput
    puts "Enter a valid four color code(XXXX). Valid Colors are : R - Red, G - Green, B - Blue, Y - Yellow, O - Orange, P - Purple"
    @guess = gets.chomp.upcase.split("")
  end
  
  def getfeedback
    puts "Please give your feedback in this format : hits,misses .For example : 2,2"
    @feedback = gets.chomp.upcase.split(",").map(&:to_i)
  end
end #class GameMastermind 

mastermind = GameMastermind.new
mastermind.play
