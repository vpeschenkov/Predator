//
//  Preferences.swift
//  PredatorClock
//
//  Created by Victor Peschenkov on 5/11/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import ScreenSaver

final class Preferences {
    
    static let shared = Preferences()
    static let animationTimeInterval = TimeInterval(1.0)
    static let preferencesIdentifier = "PreferencesWindowController"
    static let github = "https://github.com/vpeschenkov/predator-clock-screensaver"
    static let twitter = "https://twitter.com/vpeschenkov"
    
    public var primaryColor: NSColor {
        set {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: newValue), forKey: Key.primaryColor)
            defaults.synchronize()
        }
        
        get {
            return NSKeyedUnarchiver.unarchiveObject(with: defaults.object(forKey: Key.primaryColor) as! Data) as! NSColor
        }
    }
    
    public var reverseFilling: Bool {
        set {
            defaults.set(newValue, forKey: Key.reverseFilling)
            defaults.synchronize()
        }
        
        get {
            return defaults.object(forKey: Key.reverseFilling) as? Bool ?? false
        }
    }
    
    public var twentyFourClockFormat: Bool {
        set {
            defaults.set(newValue, forKey: Key.twentyFourClockFormat)
            defaults.synchronize()
        }
        
        get {
            return defaults.object(forKey: Key.twentyFourClockFormat) as? Bool ?? false
        }
    }
    
    public var isTwentyFourClockFormat: Bool {
        get {
            return twentyFourClockFormat
        }
    }
    
    public var isTwelveFourClockFormat: Bool {
        get {
            return twentyFourClockFormat == false
        }
    }
    
    // MARK: - Key
    
    private enum Key {
        static let primaryColor = "primory-color-key"
        static let reverseFilling = "reverse-filling-key"
        static let twentyFourClockFormat = "twenty-four-clock-format-key"
    }
    
    fileprivate lazy var defaults: ScreenSaverDefaults = {
        guard let bundleIdentifier = Bundle(for: Preferences.self).bundleIdentifier, let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            fatalError("Failed to retrieve settings")
        }
        defaults.register(defaults: [
            Key.primaryColor: NSKeyedArchiver.archivedData(withRootObject: NSColor.red),
            Key.reverseFilling: false,
            Key.twentyFourClockFormat: true
            ])
        return defaults
    }()
}
