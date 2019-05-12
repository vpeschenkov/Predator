//
//  PreferencesWindowController.swift
//  PredatorClock
//
//  Created by Victor Peschenkov on 5/11/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

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
