//
//  PredatorClockView.swift
//  PredatorClock
//
//  Created by Victor Peschenkov on 5/7/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import ScreenSaver

class PredatorClockView: ScreenSaverView {
    private let predator = PredatorClockScreenSaver()
    
    override var isAnimating: Bool {
        return true
    }
    
    override var hasConfigureSheet: Bool {
        return false
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        
        if let context = NSGraphicsContext.current?.cgContext {
            predator.draw(in: rect, context: context)
        }
    }
}
