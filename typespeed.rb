require "gosu"

Point = Struct.new :x, :y
Word  = Struct.new :word, :graphic, :point

class Typespeed < Gosu::Window
  HEIGHT = 600
  WIDTH  = 800

  def initialize
    super WIDTH, HEIGHT
    self.caption = "Typespeed Ruby"

    @dictionary = File.open("words.txt").lines.map(&:strip).to_a
    @words = []
    @last_word = 0
    @last_update = Gosu.milliseconds
    @available_words = (1..15).map { |i| Point.new(WIDTH / 2, (i * 30) + 3) }

    @game_over = @playing = false
    @correct_words = 0
    @input = Gosu::TextInput.new
  end

  def button_down id
    if Gosu::KbEscape == id
      exit
    elsif (!@playing || @game_over) && id == Gosu::KbQ
      exit
    elsif !@playing && id == Gosu::KbS
      @playing = true
      @last_word = Gosu.milliseconds
      self.text_input = @input
    elsif @playing && id == Gosu::KbReturn
      word = @words.detect { |w| w.word == @input.text }
      if word
        @words.delete word
        @available_words << word.point
      end

      @input = Gosu::TextInput.new
      self.text_input = @input
    end
  end

  def update
    return if @game_over || !@playing
    now = Gosu.milliseconds

    if (now - @last_word) >= 1000
      word = @dictionary.sample
      slot = @available_words.sample
      return dead! unless slot
      @available_words.delete(slot)
      @words << Word.new(word, Gosu::Font.new(24), slot)
      @last_word = now
    end
  end

  def draw
    if @game_over
      Gosu::Font.new(48).draw("Game Over", WIDTH / 2, HEIGHT / 2, 1, 1, 1, Gosu::Color::RED)
      Gosu::Font.new(24).draw("(press 'q' to quit)",  WIDTH / 2, HEIGHT / 2 + 48, 1, 1, 1, Gosu::Color::YELLOW)
      Gosu::Font.new(24).draw("(press 'r' to reset)", WIDTH / 2, HEIGHT / 2 + 96, 1, 1, 1, Gosu::Color::YELLOW)
      Gosu::Font.new(24).draw("#{(@correct_words / @game_over_at / 1000).round(1)} WPM", WIDTH / 2, HEIGHT / 2 + 120, 1, 1, 1, Gosu::Color::GREEN)
    elsif @playing
      @words.each do |word|
        word.graphic.draw(word.word, word.point.x, word.point.y, 1)
      end
      Gosu.draw_line(0, 450, Gosu::Color::RED, WIDTH, 450, Gosu::Color::RED)
    else
      Gosu::Image.from_text("Get ready to type!", 48, align: :center).draw_rot(WIDTH / 2, HEIGHT / 2, 1, 0)
      Gosu::Image.from_text("press 's' to start", 16, align: :center).draw_rot(WIDTH / 2, HEIGHT / 2 + 50, 1, 0)
    end
  end

  private

  def dead!
    @playing = false
    @game_over = true
    @game_over_at = Gosu.milliseconds
    self.text_input = nil
  end
end

Typespeed.new.show
