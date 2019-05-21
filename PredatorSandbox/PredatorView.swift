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

import Cocoa
import PredatorCore

class MainConfiguration: Configuration {
    var primaryColor: NSColor {
        return NSColor.red
    }
    
    var isReverse: Bool {
        return false
    }
    
    var isTwentyFourClock: Bool {
        return true
    }
        
    var isTwelveFourClock: Bool {
        return false
    }
        
    var isAutoInstallUpdates: Bool {
        return false
    }
        
    var isRandomColor: Bool {
        return false
    }
}

class PredatorView: NSView {
    private var timer: Timer?
    private lazy var predator = PredatorClock(with: MainConfiguration())
    
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
