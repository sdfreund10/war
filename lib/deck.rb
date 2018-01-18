# frozen_string_literal: true

class Deck
  attr_accessor :cards, :top_card
  def initialize(cards)
    @cards = cards
  end

  def draw(num = false)
    if num
      Array.new([num,cards.size].min) { draw }
    else
      @top_card = @cards.shift
    end
  end

  def empty?
    @cards.empty?
  end
end