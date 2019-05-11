//
//  PredatorClockView.swift
//  PredatorClock
//
//  Created by Victor Peschenkov on 5/7/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import ScreenSaver

class PredatorClockView: ScreenSaverView {
    private var timer: Timer?
    private let predator = PredatorClock()
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        animationTimeInterval = 1 / 30
        startAnimation()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        animationTimeInterval = 1 / 30
        startAnimation()
    }
    
    override var isAnimating: Bool {
        return true
    }
    
    override var hasConfigureSheet: Bool {
        return false
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        if let context = NSGraphicsContext.current?.cgContext {
            predator.draw(in: self.visibleRect, context: context)
        }
    }
    
    override func startAnimation() {
        super.startAnimation()
        timer = Timer.scheduledTimer(withTimeInterval: animationTimeInterval, repeats: true) { t in
            self.setNeedsDisplay(self.bounds)
        }
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        timer?.invalidate()
        timer = nil
    }
    
    override var configureSheet: NSWindow? {
        return nil
    }
}
