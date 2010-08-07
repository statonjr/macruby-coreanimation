# TransitionView.rb
# Transition
#
# Created by Larry Staton Jr. on 8/5/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class TransitionView < NSView
  
  def initWithFrame(frame)
    super
    self.addSubview(self.beach)
  end

  def acceptsFirstResponder
    true
  end

  def keyDown(event)
    if self.subviews.objectAtIndex(0).image.name == "beach"
	    self.animator.replaceSubview(self.subviews.objectAtIndex(0), with:self.snow)
	  else
	    self.animator.replaceSubview(self.subviews.objectAtIndex(0), with:self.beach)
	  end
  end
  
  def beach
    beach = self.imageViewForImageNamed("beach.jpg")
    return beach
  end

  def snow
    snow = self.imageViewForImageNamed("snow.jpg")
    return snow
  end

  def imageViewForImageNamed(imageName)
    xInset = 0.125 * NSWidth(self.frame)
    yInset = 0.125 * NSHeight(self.frame)
    subFrame = NSInsetRect(self.frame, xInset, yInset)
    subFrame.origin.x = NSMidX(self.bounds) - (NSWidth(subFrame) / 2.0)
    subFrame.origin.y = NSMidY(self.bounds) - (NSHeight(subFrame) / 2.0)
    imageView = NSImageView.alloc.initWithFrame(subFrame)
    imageView.setImageScaling NSScaleToFit
    imageView.setImage(NSImage.imageNamed(imageName))
    return imageView
  end
  
end