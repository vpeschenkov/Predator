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
    
    public var primaryColor: NSColor? {
        set {
            if let value = newValue {
                defaults.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: Key.primaryColor)
            } else {
                defaults.set(nil, forKey: Key.primaryColor)
            }
            defaults.synchronize()
        }
        
        get {
            if let value = defaults.object(forKey: Key.primaryColor) as? Data {
                return NSKeyedUnarchiver.unarchiveObject(with: value) as? NSColor
            }
            return nil
        }
    }
    
    public var reverseFilling: Bool? {
        set {
            defaults.set(newValue, forKey: Key.reverseFilling)
            defaults.synchronize()
        }
        
        get {
            return defaults.object(forKey: Key.reverseFilling) as? Bool
        }
    }
    
    // MARK: - Key
    
    private enum Key {
        static let primaryColor = "primory-color-key"
        static let reverseFilling = "reverse-filling-key"
    }
    
    fileprivate lazy var defaults: ScreenSaverDefaults = {
        guard let bundleIdentifier = Bundle(for: Preferences.self).bundleIdentifier, let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            fatalError("Failed to retrieve settings")
        }
        defaults.register(defaults: [
            Key.primaryColor: NSKeyedArchiver.archivedData(withRootObject: NSColor.red),
            Key.reverseFilling: false
            ])
        return defaults
    }()
}
