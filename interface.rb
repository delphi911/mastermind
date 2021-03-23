class Interface
    ACTIONS = {
      "q" => :quit,
      "p" => :play,
      "c" => :suggest,
      "a" => :ai
    }  
    VALID_CHOICES = ACTIONS.keys
   
    def get_valid_action
      puts "What would you like to do? (q: quit, p: human try to find, c: suggest a secret code a: computer try to find)"
      validate( gets.chomp ) || try_again
    end

    def get_action
        ACTIONS[get_valid_action]
    end

    private
  
    def validate( action )
      VALID_CHOICES.detect { |valid_action| valid_action == action }
    end  

    def try_again
      puts "Sorry, I didn't understand that."
      get_valid_action
    end
  end
