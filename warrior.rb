
class Player
  attr_accessor :health, :back_token, :move_count, :direction
  
  def play_turn(warrior)
    if !@health
      @health = warrior.health
      @move_count = 0
      @direction = :forward
    end
    
    if warrior.feel.wall?
      warrior.pivot!
    else
      warrior.feel.empty? ? next_empty_space(warrior) : warrior.attack!
    end
    
    @health = warrior.health
  end
  
  def next_empty_space(warrior)
    if @move_count > 1 
      warrior.walk!
      @move_count = 0
    else
      if warrior.health < @health
        warrior.walk!(:backward)
        @move_count = 0
      elsif warrior.health != 20
        warrior.rest!
        @move_count = 0 
      else
        warrior.walk!(@direction)
        @move_count += 1
      end
    end
  end
  
  def free_captive(warrior, direction)
    warrior.rescue!(direction)
  end
end
  