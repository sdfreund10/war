# frozen_string_literal: true
load 'lib/deck.rb'

class Game
  Card = Struct.new(:suit, :value)
  attr_accessor :player_deck, :opponent_deck

  def initialize
    @player_deck = Deck.new(full_deck.sample(26))
    @opponent_deck = Deck.new(full_deck - @player_deck.cards)
  end

  def play_round
    until @player_deck.empty? || @opponent_deck.empty?
      puts "Player: #{@player_deck.cards.size}\t|\tComputer: #{@opponent_deck.cards.size}"
      process_turn
    end
  end

  def process_turn(pot = nil)
    pot ||= [player_deck.draw, opponent_deck.draw]
    if winner.nil?
      3.times { pot += player_deck.draw(3) + opponent_deck.draw(3)}
      process_turn(pot)
    else
      winner.cards += pot
    end
  end

  def winner
    binding.pry if player_deck.top_card.value.nil? || opponent_deck.top_card.value.nil?
    if player_deck.top_card.value > opponent_deck.top_card.value
      player_deck
    elsif player_deck.top_card.value < opponent_deck.top_card.value
      opponent_deck
    end
  end


  def full_deck
    %w(H S C D).inject([]) do |deck, suit|
      (2..14).each do |value|
        deck << Card.new(suit, value)
      end
      deck
    end
  end
end
