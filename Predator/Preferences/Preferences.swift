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
