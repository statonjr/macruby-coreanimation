# MyController.rb
# CustomizeAnimation
#
# Created by Larry Staton Jr. on 8/7/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class MyController < NSObject
  
  attr_accessor :myView
  
  def makeSlow(sender)
    frameOriginAnimation = CABasicAnimation.animation
    frameOriginAnimation.setDuration(2.0)
    animations = NSDictionary.dictionaryWithObject(frameOriginAnimation, forKey:"frameOrigin")
    @myView.mover.setAnimations(animations)
  end
  
  def makeFast(sender)
    frameOriginAnimation = CABasicAnimation.animation
    frameOriginAnimation.setDuration(0.1)
    animations = NSDictionary.dictionaryWithObject(frameOriginAnimation, forKey:"frameOrigin")
    @myView.mover.setAnimations(animations)
  end
  
  def makeDefault(sender)
    @myView.mover.setAnimations(nil)
  end
end