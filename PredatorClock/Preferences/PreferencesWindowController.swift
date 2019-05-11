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
    
    override func windowDidLoad() {
        super.windowDidLoad()

        if let isReverseFiling = Preferences.shared.reverseFilling {
            reverseButton.state = isReverseFiling ? .on : .off
        } else {
            reverseButton.state = .off
        }
        
        if let color = Preferences.shared.shapesColor {
            colorPicker.color = color
        }
    }
}

// MARK: - Actions

extension PreferencesWindowController {
    
    @IBAction func reverseAction(_ sender: NSButton) {
        Preferences.shared.reverseFilling = sender.state == .on ? true : false
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func pickColorAction(_ sender: Any) {
        Preferences.shared.shapesColor = colorPicker.color
        previewView.setNeedsDisplay(previewView.bounds)
    }
    
    @IBAction func githubAction(_ sender: Any) {
        guard let url = URL(string: "https://github.com/vpeschenkov/predator-clock-screensaver") else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func twitterAction(_ sender: Any) {
        guard let url = URL(string: "https://twitter.com/vpeschenkov") else {
            return
        }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        guard let window = window else {
            return
        }
        window.sheetParent?.endSheet(window)
    }
}
