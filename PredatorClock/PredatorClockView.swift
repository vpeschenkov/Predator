//
//  PredatorClockView.swift
//  PredatorClock
//
//  Created by Victor Peschenkov on 5/7/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import ScreenSaver

final class PredatorClockView: ScreenSaverView {
    private var timer: Timer?
    private lazy var predator = PredatorClock()
    private lazy var preferences = PreferencesWindowController(windowNibName: "PreferencesWindowController")
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        animationTimeInterval = 1.0
        startAnimation()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        animationTimeInterval = 1.0
        startAnimation()
    }
    
    override var isAnimating: Bool {
        return true
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        if let context = NSGraphicsContext.current?.cgContext {
            predator.draw(in: self.visibleRect, context: context)
        }
    }
    
    override func startAnimation() {
        super.startAnimation()
        timer = Timer.scheduledTimer(
            timeInterval: animationTimeInterval,
            target: self,
            selector: #selector(animationLoopEventHandler),
            userInfo: nil,
            repeats: true
        )
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        timer?.invalidate()
        timer = nil
    }
    
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        return preferences.window
    }
    
    //MARK: - Timer
    
    @objc func animationLoopEventHandler() {
        self.setNeedsDisplay(self.bounds)
    }
}
