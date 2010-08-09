# BackgroundFilteredView.rb
# BackgroundFilteredView
#
# Created by Larry Staton Jr. on 8/8/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

KCAMediaTimingFunctionEaseInEaseOut = "easeInEaseOut"

class BackgroundFilteredView < NSView
  
  attr_accessor :controls
  
  def drawRect(rect)
    bounds = self.bounds
    stripeSize = bounds.size
    stripeSize.width = NSWidth(bounds) / 10.0
    stripe = bounds
    stripe.size = stripeSize
    colors = [NSColor.whiteColor, NSColor.blueColor]
    10.times do |color|
      colors[color % 2].set
      NSRectFill(stripe)
      stripe.origin.x += stripe.size.width
    end
  end
  
  def awakeFromNib
    self.setWantsLayer(true)
    self.applyFilter
  end
  
  def applyFilter
    center = CIVector.vectorWithX(NSMidX(self.bounds), Y:NSMidY(self.bounds))
    torus = CIFilter.filterWithName("CITorusLensDistortion")
    torus.setDefaults
    torus.name = "torus"

    controls.setBackgroundFilters(NSArray.arrayWithObjects(torus, nil))
    self.addAnimationToTorusFilter
  end
  
  def addAnimationToTorusFilter
    keyPath = NSString.stringWithFormat("backgroundFilters.torus.%@", KCIInputWidthKey)
    animation = CABasicAnimation.animationWithKeyPath(keyPath)
    animation.fromValue = NSNumber.numberWithFloat(50.0)
    animation.toValue = NSNumber.numberWithFloat(80.0)
    animation.duration = 1.0
    animation.repeatCount = 1e100
    animation.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseInEaseOut)
    animation.autoreverses = true
    controls.layer.addAnimation(animation, forKey:"torusAnimation")
  end
  
  def addFilter(sender)
    if controls.backgroundFilters || (self.backgroundFilters.count >= 0)
      self.applyFilter
    end
  end
  
  def removeFilter(sender)
    if controls.backgroundFilters || (self.backgroundFilters.count >= 0)
      self.deleteFilter
    end
  end
  
  def deleteFilter
    controls.setBackgroundFilters(nil)
  end
  
end