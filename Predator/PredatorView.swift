//
//  PredatorView.swift
//  Predator
//
//  Created by Victor Peschenkov on 5/7/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import ScreenSaver

final class PredatorView: ScreenSaverView {
    fileprivate var timer: Timer?
    fileprivate lazy var predator = PredatorClock()
    fileprivate lazy var preferences = PreferencesWindowController(windowNibName: Preferences.preferencesIdentifier)
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        configure()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        configure()
    }
    
    override func draw(_ rect: NSRect) {
        super.draw(rect)
        if let context = NSGraphicsContext.current?.cgContext {
            predator.draw(in: self.visibleRect, context: context)
        }
    }
    
    // MARK: - Pirivate Methods
    
    private func configure() {
        animationTimeInterval = Preferences.animationTimeInterval
        startAnimation()
    }
}

// MARK: - Configure Sheet

extension PredatorView {
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        return preferences.window
    }
}

// MARK: - Animation

extension PredatorView {
    override var isAnimating: Bool {
        return true
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
}

// MARK: - Timer

extension PredatorView {
    @objc func animationLoopEventHandler() {
        self.setNeedsDisplay(self.bounds)
    }
}
