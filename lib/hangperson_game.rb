class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word,:guesses,:wrong_guesses
  NUMBER_OF_TRIES =7
  def initialize(word)
    
    @word = word
    @guesses=""
    @wrong_guesses=""
   
  end
  
  def guess(str)
    
    if !(str=~ /\A[a-z]$/i)
      raise ArgumentError.new("Guess should be only 1 character")
    end
    
    if word.downcase.include? str.downcase
      if !guesses.downcase.include? str.downcase
        guesses << str
        return true
      end
        return false
    end
    
    if !wrong_guesses.downcase.include? str.downcase
          wrong_guesses << str
          return true
     end
    return false
 end

  def word_with_guesses

    if @guesses.length < 1
    return "-"*word.length
    else
    #ans= word.gsub(/[^#{@guesses}]/,"-")
    ans = word.gsub(/[^#{guesses}]/,"-")
    a="word= #{word}, ans= #{ans}"
    
    end
end
=begin
def word_with_guesses
    result = ''
    @word.split('').each do |char|
      if @guesses.include? char
        result << char
      else
        result << '-'
      end
    end
    
    
    return result
  end
  
=end
  def check_win_or_lose
    return :lose if wrong_guesses.length >= NUMBER_OF_TRIES
    return :win if word_with_guesses == word
    return :play
   
    
  end
 
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
