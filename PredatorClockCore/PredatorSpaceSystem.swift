//
//  SpaceSystem.swift
//  PredatorClockCore
//
//  Created by Victor Peschenkov on 5/8/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Foundation

public struct PredatorSpaceSystem: CoordinateSystem {
    public var centerInPoints: CGPoint {
        return CGPoint(
            x: CGFloat(self.numberOfPointsInXAxist) / 2,
            y: CGFloat(self.numberOfPointsInYAxist) / 2
        )
    }
    public var numberOfPointsInXAxist: Int
    public var numberOfPointsInYAxist: Int
    
    private var hunk: CGFloat
    private var worldSize: CGSize
    
    public init(worldSize: CGSize, numberOfPoints: Int) {
        let pixels = min(worldSize.width, worldSize.height)
        self.hunk = pixels / CGFloat(numberOfPoints)
        self.worldSize = worldSize
        self.numberOfPointsInXAxist = Int(worldSize.width / hunk)
        self.numberOfPointsInYAxist = Int(worldSize.height / hunk)
    }
    
    public func convertPointToPixels(_ point: CGFloat) -> CGFloat {
        return (point * hunk).rounded(.up)
    }
    
    public func convertPointsToPixels(_ point: CGPoint) -> CGPoint {
        return CGPoint(
            x: convertPointToPixels(point.x),
            y: convertPointToPixels(point.y)
        )
    }
}
