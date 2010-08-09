# FilteredView.rb
# FilteredView
#
# Created by Larry Staton Jr. on 8/9/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class FilteredView < NSView
  
  attr_accessor :controls
  
  def awakeFromNib
    @controls.setWantsLayer(true)
  end
  
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
  
  def pointillize
    center = CIVector.vectorWithX(NSMidX(self.bounds), Y:NSMidY(self.bounds))
    pointillize = CIFilter.filterWithName("CIPointillize", keysAndValue:[
                              KCIInputRadiusKey, NSNumber.numberWithFloat(1.0),
                              KCIInputCenterKey, center])
    pointillize.name = "pointillize"
    @controls.setContentFilters(NSArray.arrayWithObjects(pointillize,nil))
  end
  
  def noPointillize(sender)
    if 0 < @controls.contentFilters.count
      @controls.setContentFilters(nil)
    end
  end

  def heavyPointillize(sender)
    if 0 == @controls.contentFilters.count
      self.pointillize
    end
    path = NSString.stringWithFormat("contentFilters.pointillize.%@", KCIInputRadiusKey)
    @controls.setValue(NSNumber.numberWithInt(5), forKeyPath:path)
  end

  def lightPointillize(sender)
    if 0 == @controls.contentFilters.count
      self.pointillize
    end
    path = NSString.stringWithFormat("contentFilters.pointillize.%@", KCIInputRadiusKey)
    @controls.setValue(NSNumber.numberWithInt(1), forKeyPath:path)
  end
  
  
end
