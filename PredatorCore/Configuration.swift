//
//  Configuration.swift
//  PredatorCore
//
//  Created by Peschenkov, Victor on 21/05/2019.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Foundation

public protocol Configuration {
    var primaryColor: NSColor { get }
    var isReverse: Bool { get }
    var isTwentyFourClock: Bool { get }
    var isTwelveFourClock: Bool { get }
    var isAutoInstallUpdates: Bool { get }
}
