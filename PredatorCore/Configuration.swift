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
    var reverse: Bool { get }
    var twentyFourHours: Bool { get }
    var twelveHours: Bool { get }
    var drawEmptyDigits: Bool { get }
}
