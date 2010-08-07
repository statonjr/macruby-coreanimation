# Controller.rb
# LayerBackedControls
#
# Created by Larry Staton Jr. on 8/7/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class Controller < NSObject
  
  attr_accessor :rotatingButton
  
  def awakeFromNib
    rotatingButton.superview.setWantsLayer(true)
  end
  
  def rotateButton(sender)
    
  end
  
  def beep(sender)
    
  end
  
end
