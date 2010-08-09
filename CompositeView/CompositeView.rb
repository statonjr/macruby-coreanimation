# CompositeView.rb
# CompositeView
#
# Created by Larry Staton Jr. on 8/9/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class CompositeView < NSView
  
  attr_accessor :controls
  
  def applyFilter
    filter = CIFilter.filterWithName("CIColorBurnBlendMode", keysAndValues:nil)
    @controls.animator.setCompositingFilter(filter)
  end
  
  # Cannot have two methods of same name
  # -removeFilter(sender) and -removeFilter
  def deleteFilter
    @controls.animator.setCompositingFilter(nil)
  end

  def awakeFromNib
    self.setWantsLayer(true)
    self.applyFilter
  end

  def removeFilter(sender)
    if nil != controls.compositingFilter
      self.deleteFilter
    end
  end

  def addFilter(sender)
    if controls.compositingFilter.nil?
      self.applyFilter
    end
  end

  def drawRect(rect)
    NSColor.lightGrayColor.set
    NSRectFill(rect)
  end
  
end
