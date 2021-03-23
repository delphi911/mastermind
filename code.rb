class SecretCode 
    attr_accessor :secretcode

    COLOR = %w(R G B Y O P).freeze
    CODE_LENGTH = 4

    def initialize
        createcode 
    end

    def createcode 
      @secretcode = CODE_LENGTH.times.map {COLOR.sample}
      @secretcode      
    end

    def printcode
      @secretcode
    end

    def guessResult(guess)
      hitsN = guess.zip(@secretcode).select{|x| x[0]==x[1]}.count
      hitsA, remainingA = guess.zip(@secretcode).partition { |a, b| a == b }
      remainingGuess, remainingCode = remainingA.transpose
      misses = (remainingGuess || []).count do |e|
        index = remainingCode.index(e)
        remainingCode.delete_at(index) if index
      end
      [hitsN,misses]
    end
end #class Code
