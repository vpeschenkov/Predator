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

final class PreferencesWindowController: NSWindowController {
    @IBOutlet var colorPicker: NSColorWell!
    @IBOutlet var previewView: NSView!
    @IBOutlet var reverseCheckbox: NSButton!
    @IBOutlet var twentyHourCheckbox: NSButton!
    @IBOutlet var drawEmptyDigitsCheckbox: NSButton!
    @IBOutlet var versionLabel: NSTextField!
    
    private lazy var preferences = Preferences.shared
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        colorPicker.color = preferences.primaryColor
        reverseCheckbox.state = preferences.reverse ? .on : .off
        twentyHourCheckbox.state = preferences.twentyFourHours ? .on : .off
        drawEmptyDigitsCheckbox.state = preferences.drawEmptyDigits ? .on : .off
        
        if let version = preferences.bundle.infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.stringValue = "Predator's version  \(version)"
        }
    }
    
    @objc func sparkleWillRestart() {
        window?.sheetParent?.endSheet(window!)
        for app in NSWorkspace.shared.runningApplications where app.bundleIdentifier == "com.apple.systempreferences" {
            app.terminate()
        }
    }
}

// MARK: - Actions

extension PreferencesWindowController {
    
    @IBAction func reverseAction(_ sender: NSButton) {
        preferences.reverse = sender.state == .on ? true : false
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func pickColorAction(_ sender: Any) {
        preferences.primaryColor = colorPicker.color
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func twentyFourClockFormatAction(_ sender: NSButton) {
        preferences.twentyFourHours = sender.state == .on ? true : false
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func drawEmptyDigitsAction(_ sender: NSButton) {
        preferences.drawEmptyDigits = sender.state == .on ? true : false
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func githubAction(_ sender: Any) {
        guard let url = URL(string: Preferences.github) else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func twitterAction(_ sender: Any) {
        guard let url = URL(string: Preferences.twitter) else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        NSColorPanel.shared.close()
        guard let window = window else {
            return
        }
        window.sheetParent?.endSheet(window)
    }
}
