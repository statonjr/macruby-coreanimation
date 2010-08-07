# CustomView.rb
# CustomAnimationTiming
#
# Created by Larry Staton Jr. on 8/7/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class CustomView < NSView
  
  attr_accessor :mover
  
  def initWithFrame(frame)
    super
    self.setupMover
    self
  end
  
  def setupMover
    bounds = self.bounds
    moverFrame = NSInsetRect(bounds, NSWidth(bounds) / 4.0, NSHeight(bounds) / 4.0)
    moverFrame.origin.x = 0.0
    @mover = NSImageView.alloc.initWithFrame(moverFrame)
    @mover.setImageScaling NSScaleToFit
    @mover.setImage(NSImage.imageNamed "WiiDaddy.jpg")
    self.addSubview(@mover)
  end
  
  def acceptsFirstResponder
    true
  end
  
  def keyDown(event)
    self.move
  end
  
  def move
    animations = NSDictionary.dictionaryWithObject(self.moveAnimation, forKey:"frameOrigin")
    @mover.setAnimations(animations)
    origin = @mover.frame.origin
    origin.x += NSWidth(@mover.frame)
    @mover.animator.setFrameOrigin(origin)
  end
  
  def moveAnimation
    moveAnimation = CABasicAnimation.animation
    moveAnimation.duration = 2.0
    c1x = 0.25
    c1y = 1.0
    c2x = 0.75
    c2y = 0.0
    tf = CAMediaTimingFunction.alloc
    tf.send "initWithControlPoints::::".to_sym, c1x, c1y, c2x, c2y
    moveAnimation.timingFunction = tf
    return moveAnimation
  end
  
end