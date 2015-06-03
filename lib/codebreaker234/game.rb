module Codebreaker234
  class Game
  	NUMBER_OF_TURNS = 10
    SECRET_CODE_LENGTH = 4 

    attr_accessor :user_guesses_and_answers, :game_status, :result_saved
    attr_reader :number_of_turns, :hints_avaliable

  	def initialize
      @secret_code = ""
      @number_of_turns = NUMBER_OF_TURNS 
      @hint_position = rand(SECRET_CODE_LENGTH)
      @hints_avaliable = 1
      @user_guesses_and_answers = []
      @game_status = "not_completed"
      @result_saved = false
    end
 
    def start
      SECRET_CODE_LENGTH.times {@secret_code << (1 + rand(6)).to_s}
    end

    def mark_user_guess(user_input)
    	answer = ""
      tmp_code = ""
      tmp_input = ""
      for i in 0...SECRET_CODE_LENGTH
        if user_input[i] == @secret_code[i]
          tmp_code << "+"
          tmp_input << "+"
        else 
          tmp_input << user_input[i]
          tmp_code << @secret_code[i]
        end 
      end
    	for i in 0...SECRET_CODE_LENGTH
    		if tmp_input[i] == tmp_code[i]
    			answer << "+"
    		elsif tmp_code.include? tmp_input[i]
    			answer << "-"
    		end	
    	end
      return answer
    end

    def hint
      hint = "****" 
      hint[@hint_position] = @secret_code[@hint_position]
      @hints_avaliable -= 1
      return hint
    end

    def decrease_avaliable_turns
      @number_of_turns -= 1  
    end

    def score
      @number_of_turns*10 + @hints_avaliable*30
    end

    def save_to(file_name)
      File.open(file_name, 'w') {|f| f.write(YAML.dump(self)) }
    end

    def self.load_from(file_name)
      YAML.load(File.read(file_name))
    end
  end
end


