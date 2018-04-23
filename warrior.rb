

class Player
  attr_accessor :health, :back_token, :move_count
  
  def play_turn(warrior)
    if !@health
      @health = warrior.health
      @move_count = 0
    end
    
    if !back_token
      warrior.feel(:backward).empty? ? self.next_empty_space(warrior, :backward) : @back_token = true
      @move_count = 0
    else
      if warrior.feel(:forward).captive? 
        self.free_captive(warrior, :forward)
        @move_count = 0
      elsif warrior.feel(:backward).captive? 
        self.free_captive(warrior, :backward)
        @move_count = 0
      else  
         warrior.feel.empty? ? self.next_empty_space(warrior, :forward) : warrior.attack!
      end
    end
    
    @health = warrior.health
  end
  
  def next_empty_space(warrior, direction)
    if @move_count > 1
      warrior.walk!
      @move_count = 0
    elsif warrior.health < @health && warrior.health != 20
      warrior.walk!(:backward)
    elsif warrior.health >= @health && warrior.health != 20
      warrior.rest!
    else
      warrior.walk!(direction)
      @move_count += 1
    end
  end
  
  def free_captive(warrior, direction)
    warrior.rescue!(direction)
  end
end
  