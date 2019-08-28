//  Copyright 2019 Victor Peschenkov
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import ScreenSaver
import PredatorCore

final class PredatorView: ScreenSaverView {
    fileprivate var timer: Timer?
    fileprivate lazy var predator = PredatorClock(with: Preferences.shared)
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
