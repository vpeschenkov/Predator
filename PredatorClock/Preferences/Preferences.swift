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
    
    public var primaryColor: NSColor? {
        set {
            if let value = newValue {
                Preferences.standard.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: Key.primaryColor)
            } else {
                Preferences.standard.set(nil, forKey: Key.primaryColor)
            }
            Preferences.standard.synchronize()
        }
        
        get {
            if let value = Preferences.standard.object(forKey: Key.primaryColor) as? Data {
                return NSKeyedUnarchiver.unarchiveObject(with: value) as? NSColor
            }
            return nil
        }
    }
    
    public var reverseFilling: Bool? {
        set {
            Preferences.standard.set(newValue, forKey: Key.reverseFilling)
            Preferences.standard.synchronize()
        }
        
        get {
            return Preferences.standard.object(forKey: Key.reverseFilling) as? Bool
        }
    }
    
    // MARK: Key
    private enum Key {
        static let primaryColor = "primory-color-key"
        static let reverseFilling = "reverse-filling-key"
    }
    
    static fileprivate var standard: ScreenSaverDefaults {
        guard let bundleIdentifier = Bundle(for: Preferences.self).bundleIdentifier, let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            fatalError("Failed to retrieve settings")
        }
        defaults.register(defaults: [
            Key.primaryColor: NSKeyedArchiver.archivedData(withRootObject: NSColor.red),
            Key.reverseFilling: false
            ])
        return defaults
    }
}
