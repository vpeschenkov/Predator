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
    @IBOutlet var reverseButton: NSButton!
    @IBOutlet var previewView: NSView!
    @IBOutlet var twentyHourButton: NSButton!
    
    private lazy var preferences = Preferences.shared
    
    override func windowDidLoad() {
        super.windowDidLoad()

        colorPicker.color = preferences.primaryColor
        reverseButton.state = preferences.reverseFilling ? .on : .off
        twentyHourButton.state = preferences.twentyFourClockFormat ? .on : .off
    }
}

// MARK: - Actions

extension PreferencesWindowController {
    
    @IBAction func reverseAction(_ sender: NSButton) {
        preferences.reverseFilling = sender.state == .on ? true : false
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func pickColorAction(_ sender: Any) {
        preferences.primaryColor = colorPicker.color
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func twentyFourClockFormat(_ sender: NSButton) {
        preferences.twentyFourClockFormat = sender.state == .on ? true : false
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
