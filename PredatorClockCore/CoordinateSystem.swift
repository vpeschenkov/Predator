//
//  CoordinateSystem.swift
//  PredatorClockCore
//
//  Created by Victor Peschenkov on 5/8/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Cocoa

public protocol CoordinateSystem {
    var centerInPoints: CGPoint { get }
    var numberOfPointsInXAxist: Int { get }
    var numberOfPointsInYAxist: Int { get }
    
    func convertPointToPixels(_ point: CGFloat) -> CGFloat
    func convertPointsToPixels(_ point: CGPoint) -> CGPoint
}
