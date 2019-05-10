//
//  PredatorClockView.swift
//  PredatorClockSandbox
//
//  Created by Victor Peschenkov on 5/7/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Cocoa
import PredatorClockCore

class PredatorClockView: NSView {
    private let predator = PredatorClock()
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { t in
            self.display()
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if let context = NSGraphicsContext.current?.cgContext {
            context.setFillColor(CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            context.fill(dirtyRect)
            predator.draw(in: dirtyRect, context: context)
        }
    }
}
