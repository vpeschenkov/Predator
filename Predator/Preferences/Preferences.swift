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

final class Preferences: Configuration {
    
    static public let shared = Preferences()
    static public let animationTimeInterval = TimeInterval(1.0)
    static public let preferencesIdentifier = "PreferencesWindowController"
    static public let github = "https://github.com/vpeschenkov/predator-clock-screensaver"
    static public let twitter = "https://twitter.com/vpeschenkov"
    
    public let bundle = Bundle(for: Preferences.self)
    
    public var primaryColor: NSColor {
        set {
            defaults.set(NSKeyedArchiver.archivedData(withRootObject: newValue), forKey: Key.primaryColor)
            defaults.synchronize()
        }
        
        get {
            return NSKeyedUnarchiver.unarchiveObject(with: defaults.object(forKey: Key.primaryColor) as! Data) as! NSColor
        }
    }
    
    public var reverse: Bool {
        set {
            defaults.set(newValue, forKey: Key.reverseFilling)
            defaults.synchronize()
        }
        
        get {
            return defaults.bool(forKey: Key.reverseFilling)
        }
    }
    
    public var twentyFourHours: Bool {
        set {
            defaults.set(newValue, forKey: Key.twentyFourClockFormat)
            defaults.synchronize()
        }
        
        get {
            return defaults.bool(forKey: Key.twentyFourClockFormat)
        }
    }
    
    public var twelveHours: Bool {
        get {
            return twentyFourHours == false
        }
    }
    
    public var autoUpdates: Bool {
        set {
            defaults.set(newValue, forKey: Key.autoInstallUpdates)
            defaults.synchronize()
        }
        
        get {
            return defaults.bool(forKey: Key.autoInstallUpdates)
        }
    }
    
    public var drawEmptyDigits: Bool {
        set {
            defaults.set(newValue, forKey: Key.drawEmptyDigits)
            defaults.synchronize()
        }
        
        get {

            return defaults.bool(forKey: Key.drawEmptyDigits)
        }
    }
    
    // MARK: - Keys
    
    private enum Key {
        static let primaryColor = "primory-color-key"
        static let reverseFilling = "reverse-filling-key"
        static let twentyFourClockFormat = "twenty-four-clock-format-key"
        static let autoInstallUpdates = "auto-install-updates"
        static let drawEmptyDigits = "draw-empty-digits"
    }
    
    fileprivate lazy var defaults: ScreenSaverDefaults = {
        guard let bundleIdentifier = bundle.bundleIdentifier, let defaults = ScreenSaverDefaults(forModuleWithName: bundleIdentifier) else {
            fatalError("Failed to retrieve settings")
        }
        
        defaults.register(defaults: [
            Key.primaryColor: NSKeyedArchiver.archivedData(withRootObject: NSColor.red),
            Key.reverseFilling: false,
            Key.twentyFourClockFormat: true,
            Key.autoInstallUpdates: false,
            Key.drawEmptyDigits: false
            ])
        return defaults
    }()
}
