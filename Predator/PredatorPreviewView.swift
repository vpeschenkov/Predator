//
//  PredatorPreviewView.swift
//  Predator
//
//  Created by Victor Peschenkov on 5/11/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Cocoa

final class PredatorPreviewView: NSView {
    private let predator = PredatorClock()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if let context = NSGraphicsContext.current?.cgContext {
            context.setFillColor(CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            context.fill(dirtyRect)
            predator.draw(in: dirtyRect, context: context)
        }
    }
}
