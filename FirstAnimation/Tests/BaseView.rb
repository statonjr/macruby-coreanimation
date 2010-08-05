# BaseView.rb
# FirstAnimation
#
# Created by Larry Staton Jr. on 8/5/10.
# Copyright 2010 Sweetpea Software. All rights reserved.

class BaseView < NSView
  
  attr_accessor :isRight
  attr_accessor :mover
  attr_accessor :leftSidePosition
  attr_accessor :rightSidePosition
  
  def awakeFromNib
    self.initializeFramePositions
    self.addImageToSubview
    self.addSubview(@mover)
    self
  end
  
  def initializeFramePositions
    @leftSidePosition = NSMakeRect(0.0, 0.0, 100.0, 200.0)
    @rightSidePosition = NSMakeRect(400.00, 200.0, 50.0, 100.0)
    @mover = NSImageView.alloc.initWithFrame(@leftSidePosition)
	  NSLog "mover: #{@mover}"
    @isRight = false
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
      @mover.animator.setFrame(@leftSidePosition)
    else
      @mover.animator.setFrame(@rightSidePosition)
    end
    @isRight = !@isRight
  end
  
end