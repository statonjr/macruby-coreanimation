# MyView.rb
# CustomizeAnimation
#
# Created by Larry Staton Jr. on 8/7/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class MyView < NSView
  
  attr_accessor :isRight
  attr_accessor :mover
  attr_accessor :leftPosition
  attr_accessor :rightPosition
  
  def awakeFromNib
    self.initializeFramePositions
    self.addImageToSubview
    self.addSubview(@mover)
    self
  end
  
  def initializeFramePositions
    moverRect = NSInsetRect(self.bounds, self.bounds.size.width / 4.0, self.bounds.size.height / 4.0)
    moverRect.origin.x = 0.0
  	@mover = NSImageView.alloc.initWithFrame(moverRect)
    @leftPosition = NSMakePoint(0.0, NSMinY(moverRect))
  	@rightPosition = NSMakePoint(NSMaxX(self.bounds) - NSWidth(moverRect), NSMinY(moverRect)) 
  	isRight = false
  end
  
  def addImageToSubview
    @mover.setImageScaling(NSScaleToFit)
    @mover.setImage(NSImage.imageNamed:"WiiDaddy.jpg")
  end
  
  def acceptsFirstResponder
    true
  end
  
  def keyDown(event)
    self.move
  end
  
  def move
    if @isRight
      target = leftPosition
    else
      target = rightPosition
    end
    @mover.animator.setFrameOrigin(target)
    @isRight = !@isRight
  end

  
end
