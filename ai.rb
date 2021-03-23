class Ai
  attr_reader :guesspool, :aiguess

  def initialize
    @guesspool = SecretCode::COLOR.repeated_permutation(4).to_a
    @aiguess = nil
    @code = SecretCode.new
    @feedback = nil
  end

  def makeaguess(guess,feedback)
    @feedback = feedback
    return makenewguess(guess) if guess
    @guesspool.delete_at(@guesspool.find_index(%w(R R G G)))
    @aiguess=%w(R R G G)
  end

  private

  def makenewguess(guess)
    @code.secretcode = guess 
    @guesspool.select!.with_index do |currentcode, i| 
      @code.guessResult(currentcode) == @feedback
    end
    @aiguess =@guesspool.sample(1).flatten
    @guesspool.delete_at(@guesspool.find_index(@aiguess))
    @aiguess
  end
end #class Ai
