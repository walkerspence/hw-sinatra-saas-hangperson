class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError.new("Guess must not be nil") if letter.nil?
    raise ArgumentError.new("Guess cannot be empty") if letter == ''
    raise ArgumentError.new("Guess must be a letter") unless /[A-z]/.match(letter)
    letter.downcase!


    if @guesses.include? letter or @wrong_guesses.include? letter
      false
    else
      if word.include? letter
        @guesses += letter
      else
        @wrong_guesses += letter
      end
      true
    end
  end

  def word_with_guesses
    if @guesses.length > 0
      @word.gsub(/[^#{@guesses}]/, '-')
    else
      '-' * @word.length
    end
  end

  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length >= 7
      :lose
    else
      :play
    end
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
