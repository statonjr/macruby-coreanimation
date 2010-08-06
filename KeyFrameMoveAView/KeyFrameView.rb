# KeyFrameView.rb
# KeyFrameMoveAView
#
# Created by Larry Staton Jr. on 8/5/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class KeyFrameView < NSView
  
  attr_accessor :mover
  
  def addBounceAnimation
    animationDict = NSDictionary.dictionaryWithObject(self.originAnimation, forKey:"frameOrigin")
    @mover.setAnimations(animationDict)
  end
  
  def initWithFrame(frame)
    super.initWithFrame(frame)
    xInset = 3.0 * (NSWidth(frame)/8.0)
    yInset = 3.0 * (NSHeight(frame)/8.0)
    moverFrame = NSInsetRect(frame, xInset, yInset)
    @mover = NSImageView.alloc.initWithFrame(moverFrame)
    @mover.setImageScaling(NSScaleToFit)
    @mover.setImage(NSImage.imageNamed("WiiDaddy.jpg"))
    self.addSubview(@mover)
    self.addBounceAnimation
    self
  end
  
  def setFrameOrigin(newOrigin)
    super.setFrameOrigin(newOrigin)
  end
  
  def heartPath
    f = @mover.frame
    if !heartPath
      heartPath = CGPathCreateMutable()
      CGPathMoveToPoint(heartPath, NULL, NSMinX(f), NSMinY(f))
      CGPathAddLineToPoint(heartPath, NULL, NSMinX(f) - NSWidth(f), NSMinY(f) + NSHeight(f) * 0.85)
      CGPathAddLineToPoint(heartPath, NULL, NSMinX(f), NSMinY(f) - NSHeight(f) * 1.5)
      CGPathAddLineToPoint(heartPath, NULL, NSMinX(f) + NSWidth(f), NSMinY(f) + NSHeight(f) * 0.85)
      CGPathAddLineToPoint(heartPath, NULL, NSMinX(f), NSMinY(f))
      CGPathCloseSubpath(heartPath)
    end
    return heartPath
  end
  
  def originAnimation
    originAnimation = CAKeyframeAnimation.animation
    originAnimation.path = self.heartPath
    originAnimation.duration = 2.0
    originAnimation.calculationMode = kCAAnimationPaced
    return originAnimation
  end
  
  def acceptsFirstResponder
    true
  end
  
  def keyDown(event)
    self.bounce
  end
  
  def bounce
    rect = @mover.frame
    @mover.animator.setFrameOrigin(rect.origin)
  end
  
  def drawRect(dirtyRect)
    ctx = NSGraphicsContext.currentContext.graphicsPort
    CGContextAddPath(ctx, self.heartPath)
    CGContextStrokePath(ctx)
  end
  
end