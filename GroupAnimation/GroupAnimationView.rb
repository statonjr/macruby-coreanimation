# GroupAnimationView.rb
# GroupAnimation
#
# Created by Larry Staton Jr. on 8/5/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class GroupAnimationView < NSView
  
  attr_accessor :mover
  
  def frameAnimation(aniFrame)
    frameAnimation = CAKeyframeAnimation.animationWithKeyPath("frame")
    aniStart = aniFrame
    aniEnd = NSInsetRect(aniFrame, -NSWidth(aniStart) * 0.50, -NSHeight(aniStart) * 0.50)
    frameAnimation.values = NSArray.arrayWithObjects(NSValue.valueWithRect(aniStart),
                                                      NSValue.valueWithRect(aniEnd),
                                                      nil)
    return frameAnimation;
  end

  def rotationAnimation
    rotation = CABasicAnimation.animationWithKeyPath("frameRotation")
    rotation.fromValue = NSNumber.numberWithFloat(0.0)
    rotation.toValue = NSNumber.numberWithFloat(45.0)
    return rotation;
  end

  def groupAnimation(frame)
    group = CAAnimationGroup.animation
    group.animations = NSArray.arrayWithObjects(self.frameAnimation(frame),self.rotationAnimation,nil)
    group.duration = 1.0
    group.autoreverses = true
    return group;
  end

  def initWithFrame(frame)
    super

    xInset = 3.0 * (NSWidth(frame) / 8.0);
    yInset = 3.0 * (NSHeight(frame) / 8.0);
    moverFrame = NSInsetRect(frame, xInset, yInset);
    moverFrame.origin.x = NSMidX(self.bounds) - (NSWidth(moverFrame) / 2.0);
    moverFrame.origin.y = NSMidY(self.bounds) - (NSHeight(moverFrame) / 2.0);
    @mover = NSImageView.alloc.initWithFrame(moverFrame)
    @mover.setImageScaling NSScaleToFit
    @mover.setImage(NSImage.imageNamed "WiiDaddy.jpg")
    animations = NSDictionary.dictionaryWithObject(self.groupAnimation(moverFrame), forKey: "frameRotation")
    @mover.setAnimations(animations)
    self.addSubview(mover)
    
    self
  end

  def acceptsFirstResponder
    true
  end

  def keyDown(event)
    @mover.animator.setFrameRotation(@mover.frameRotation)
  end
  
end
