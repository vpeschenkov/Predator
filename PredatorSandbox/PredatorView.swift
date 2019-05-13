//
//  PredatorClockView.swift
//  PredatorSandbox
//
//  Created by Victor Peschenkov on 5/7/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Cocoa
import PredatorCore

class PredatorView: NSView {
    private var timer: Timer?
    private let predator = PredatorClock()
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        timer = Timer.scheduledTimer(
            timeInterval: 0.16,
            target: self,
            selector: #selector(animationLoopEventHandler),
            userInfo: nil,
            repeats: true
        )
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        if let context = NSGraphicsContext.current?.cgContext {
            context.setFillColor(CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            context.fill(dirtyRect)
            predator.draw(in: dirtyRect, context: context)
        }
    }
    
    //MARK: - Timer
    
    @objc func animationLoopEventHandler() {
        self.setNeedsDisplay(self.bounds)
    }
}
