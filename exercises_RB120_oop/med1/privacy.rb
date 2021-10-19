class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end
  
  def switch_status
    switch
  end
  
  def to_s
    if switch == :on
      "The machine is on."
    else
      "The machine is off"
    end
  end
  
  private
  
  attr_reader :switch
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

r2d2 = Machine.new
p r2d2.switch_status
r2d2.start
p r2d2.switch_status
r2d2.stop
p r2d2.switch_status
puts r2d2