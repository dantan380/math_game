require './player.rb'

class Game

  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @winner = false
    @turn = 1
  end

  def play
    while !self.winner
      puts "---------- NEW TURN ----------"
      if self.turn % 2 == 0
        player_turn = self.player2
        player_give_ques = self.player1
      else
        player_turn = self.player1
        player_give_ques = self.player2
      end
      new_question player_turn, player_give_ques
      self.turn += 1
    end
    puts "---------- GAME OVER ----------"
  end

  def new_question player_turn, player_give_ques
    num1 = rand(1..20)
    num2 = rand(1..20)

    puts "#{player_turn.name}: What does #{num1} plus #{num2} equal?"
    print ">"

    answer = $stdin.gets.chomp.to_i

    player_turn.lose_life if answer != (num1 + num2)

    self.winner = true if player_give_ques.lives == 0
    
    valid = answer == (num1 + num2)
    q_result valid, player_turn, player_give_ques

  end

  def q_result correct, player_turn, player_give_ques
    if correct
      puts "#{player_turn.name} has answered correctly!"
      puts "#{player_turn.name}❤️ : #{player_turn.lives}/3 vs #{player_give_ques.name}❤️ : #{player_give_ques.lives}/3"
    else 
      puts "#{player_turn.name} has answered incorrectly!"
      puts "#{player_turn.name}❤️ : #{player_turn.lives}/3 vs #{player_give_ques.name}❤️ : #{player_give_ques.lives}/3"
    end

    if self.winner
      puts "#{player_turn.name} wins with a score of #{player_turn.lives}/3!"
    end

  end

    attr_accessor :player1, :player2, :winner, :turn

end