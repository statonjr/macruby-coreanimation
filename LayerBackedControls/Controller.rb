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
    rotation = rotatingButton.frameCenterRotation
    rotatingButton.setFrameCenterRotation(rotation + 15.0)
  end
  
  def beep(sender)
    NSBeep()
  end
  
end
