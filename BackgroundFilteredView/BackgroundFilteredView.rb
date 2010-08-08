# BackgroundFilteredView.rb
# BackgroundFilteredView
#
# Created by Larry Staton Jr. on 8/8/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

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
    # self.applyFilter
  end
  
  def applyFilter
    
  end
  
  def addFilter(sender)
    
  end
  
  def removeFilter(sender)
    
  end
  
end