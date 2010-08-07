# TimedAnimation.rb
# TimedAnimation
#
# Created by Larry Staton Jr. on 8/7/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class TimedAnimation < NSView
  
  attr_accessor :snow, :beach
  
  def initWithFrame(frame)
    super
    xInset = NSWidth(frame) / 3.0
    yInset = NSHeight(frame) / 3.0
    frame = NSInsetRect(frame, xInset, yInset);

    frame.origin.x = 0.0
    frame.origin.y = NSMidY(self.bounds) - (NSHeight(frame) / 2.0)
    @beach = NSImageView.alloc.initWithFrame(frame)
    @beach.setImageScaling NSScaleToFit
    @beach.setImage(NSImage.imageNamed("beach.jpg"))
    self.addSubview(@beach)

    frame.origin.x = NSMidX(self.bounds) - (NSWidth(frame) / 2.0)
    @snow = NSImageView.alloc.initWithFrame(frame)
    @snow.setImageScaling NSScaleToFit
    @snow.setImage(NSImage.imageNamed("snow.jpg"))
    self.addSubview(@snow)
    self
  end

  def basicAnimationNamed(name, duration:duration) 
    animation = CABasicAnimation.animation
    animation.duration = duration
    animation.setValue(name, forKey:"name")
    return animation
  end
  
  def acceptsFirstResponder
    true
  end

  def keyDown(event)
    if event.characters.characterAtIndex(0) == NSRightArrowFunctionKey
      self.right
    elsif event.characters.characterAtIndex(0) == NSLeftArrowFunctionKey
      self.reset
    else
      super.keyDown(event)
    end
  end

  def right
    newOrigin = @snow.frame.origin
    animation = self.basicAnimationNamed("beach", duration:1.0)
    animation.delegate = self
    @beach.setAnimations(NSDictionary.dictionaryWithObject(animation, forKey:"frameOrigin"))
    @beach.animator.setFrameOrigin(newOrigin)
  end

  def reset
    @beach.setAnimations(nil)
    @snow.setAnimations(nil)

    newPhoto1Origin = NSMakePoint(0.0, 
                                  NSMidY(self.frame) - (NSHeight(@beach.bounds) / 2.0))
    newPhoto2Origin = NSMakePoint(NSMidX(self.frame) - (NSWidth(@snow.bounds) / 2.0), 
                                  NSMidY(self.frame) - (NSHeight(@snow.bounds) / 2.0))

    @beach.animator.setFrameOrigin(newPhoto1Origin)
    @snow.animator.setFrameOrigin(newPhoto2Origin)
  end
  
  # Animation delegate
  def animationDidStop(animation, finished:flag)
    if flag && (animation.valueForKey("name") == "beach")
      snowAnimation = self.basicAnimationNamed("snow", duration:animation.duration)
      @snow.setAnimations(NSDictionary.dictionaryWithObject(snowAnimation, forKey:"frameOrigin"))
      newPhoto2Origin = NSMakePoint(NSMaxX(self.frame) - @snow.frame.size.width, @snow.frame.origin.y)
      @snow.animator.setFrameOrigin(newPhoto2Origin)
    end
  end
end