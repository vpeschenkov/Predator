//
//  PredatorClockDrawer.swift
//  PredatorClockCore
//
//  Created by Victor Peschenkov on 5/8/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Cocoa
import QuartzCore

// MARK:- Predator Clock Screen Saver

open class PredatorClock {
    
    private var space: CoordinateSystem?
    
    public init() {
        
    }
    
    public func draw(in rect: CGRect, context: CGContext) {
        let date = Date()
        let calendar = Calendar.current
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let width = min(rect.size.width, rect.size.height) * 0.25
        let height = width * 1.5
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        let nummberSize = CGSize(width: width, height: height)
        drawPredatorHourHight(in: CGRect(
            x: center.x - nummberSize.width * 2.0,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(hours / 10))
        drawPredatorHourLow(in: CGRect(
            x: center.x - nummberSize.width,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(hours % 10))
        drawPredatorMinuteHight(in: CGRect(
            x: center.x,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(minutes / 10))
        drawPredatorMinuteLow(in: CGRect(
            x: center.x + nummberSize.width,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(minutes % 10))
    }
    
    // MARK:- Hours
    
    func drawPredatorHourHight(in rect: CGRect, context: CGContext, value: Int) {
        let width = rect.size.width * 0.384
        let height = width * 0.2
        let shape = CGSize(width: width, height: height)
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 2.0)
        let draw = { (point: CGPoint, angle: CGFloat, enabled: Bool) in
            self.drawPredatorLine(in: context, point:point, shape: shape, angle:angle, enabled: enabled)
        }
        // Define lines
        let p1 = CGPoint(x: center.x + shape.height / 2.0, y: rect.origin.y + rect.height - shape.width)
        let p2 = CGPoint(x: p1.x - shape.width * 1.268, y: p1.y - shape.height * 0.343)
        let p3 = CGPoint(x: p1.x + shape.width * 0.068, y: p1.y - shape.height * 0.343)
        let p4 = CGPoint(x: p1.x - shape.width * 1.013, y: p1.y - shape.width * 0.934)
        let p5 = CGPoint(x: p1.x + shape.width * 0.113, y: p1.y - shape.width * 0.234)
        let p6 = CGPoint(x: p4.x - shape.width * 0.137, y: p4.y - shape.height * 0.431)
        let p7 = CGPoint(x: p1.x, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.313, y: p7.y - shape.height)
        let p9 = CGPoint(x: p1.x + shape.width * 0.268, y: p6.y - shape.width * 0.713)
        // Drawing
//        context.setStrokeColor(CGColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0))
//        context.stroke(rect)
        draw(p1, 90, (value >= 1))
        draw(p2, 0, (value >= 1))
        draw(p3, 0, (value >= 1))
        draw(p4, 45, (value >= 1))
        draw(p5, -45, (value >= 1))
        draw(p6, -45, (value >= 2))
        draw(p7, 90, (value >= 2))
        draw(p8, 90, (value >= 2))
        draw(p9, 45, (value >= 2))
    }
    
    func drawPredatorHourLow(in rect: CGRect, context: CGContext, value: Int) {
        let width = rect.size.width * 0.384
        let height = width * 0.2
        let shape = CGSize(width: width, height: height)
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 2.0)
        let draw = { (point: CGPoint, angle: CGFloat, enabled: Bool) in
            self.drawPredatorLine(in: context, point:point, shape: shape, angle:angle, enabled: enabled)
        }
        // Define lines
        let p1 = CGPoint(x: center.x + shape.height / 2.0, y: rect.origin.y + rect.height - shape.width)
        let p2 = CGPoint(x: p1.x - shape.width * 1.268, y: p1.y - shape.height * 0.343)
        let p3 = CGPoint(x: p1.x + shape.width * 0.068, y: p1.y - shape.height * 0.343)
        let p4 = CGPoint(x: p1.x - shape.width * 1.013, y: p1.y - shape.width * 0.934)
        let p5 = CGPoint(x: p1.x + shape.width * 0.113, y: p1.y - shape.width * 0.234)
        let p6 = CGPoint(x: p4.x - shape.width * 0.137, y: p4.y - shape.height * 0.431)
        let p7 = CGPoint(x: p1.x, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.313, y: p7.y - shape.height)
        let p9 = CGPoint(x: p1.x + shape.width * 0.268, y: p6.y - shape.width * 0.713)
        // Drawing
        draw(p1, 90, (value >= 1))
        draw(p2, 0, (value >= 2))
        draw(p3, 0, (value >= 3))
        draw(p4, 45, (value >= 4))
        draw(p5, -45, (value >= 5))
        draw(p6, -45, (value >= 6))
        draw(p7, 90, (value >= 7))
        draw(p8, 90, (value >= 9))
        draw(p9, 45, (value >= 8))
    }
    
    // MARK:- Minutes
    
    func drawPredatorMinuteHight(in rect: CGRect, context: CGContext, value: Int) {
        let width = rect.size.width * 0.384
        let height = width * 0.2
        let shape = CGSize(width: width, height: height)
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 2.0)
        let draw = { (point: CGPoint, angle: CGFloat, enabled: Bool) in
            self.drawPredatorLine(in: context, point:point, shape: shape, angle:angle, enabled: enabled)
        }
        // Define lines
        let p1 = CGPoint(x: center.x + shape.height / 2.0, y: rect.origin.y + rect.height - shape.width)
        let p2 = CGPoint(x: p1.x - shape.width * 1.268, y: p1.y - shape.height * 0.343)
        let p3 = CGPoint(x: p1.x + shape.width * 0.068, y: p1.y - shape.height * 0.343)
        let p4 = CGPoint(x: p1.x - shape.width * 1.013, y: p1.y - shape.width * 0.934)
        let p5 = CGPoint(x: p1.x + shape.width * 0.113, y: p1.y - shape.width * 0.234)
        let p6 = CGPoint(x: p4.x - shape.width * 0.137, y: p4.y - shape.height * 0.431)
        let p7 = CGPoint(x: p1.x, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.313, y: p7.y - shape.height)
        let p9 = CGPoint(x: p1.x + shape.width * 0.268, y: p6.y - shape.width * 0.713)
        // Drawing
        draw(p1, 90, (value >= 1))
        draw(p2, 0, (value >= 1))
        draw(p3, 0, (value >= 2))
        draw(p4, 45, (value >= 2))
        draw(p5, -45, (value >= 3))
        draw(p6, -45, (value >= 3))
        draw(p7, 90, (value >= 4))
        draw(p8, 90, (value >= 5))
        draw(p9, 45, (value >= 4))
    }
    
    func drawPredatorMinuteLow(in rect: CGRect, context: CGContext, value: Int) {
        let width = rect.size.width * 0.384
        let height = width * 0.2
        let shape = CGSize(width: width, height: height)
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 2.0)
        let draw = { (point: CGPoint, angle: CGFloat, enabled: Bool) in
            self.drawPredatorLine(in: context, point:point, shape: shape, angle:angle, enabled: enabled)
        }
        // Define lines
        let p1 = CGPoint(x: center.x + shape.height / 2.0, y: rect.origin.y + rect.height - shape.width)
        let p2 = CGPoint(x: p1.x - shape.width * 1.268, y: p1.y - shape.height * 0.343)
        let p3 = CGPoint(x: p1.x + shape.width * 0.068, y: p1.y - shape.height * 0.343)
        let p4 = CGPoint(x: p1.x - shape.width * 1.013, y: p1.y - shape.width * 0.934)
        let p5 = CGPoint(x: p1.x + shape.width * 0.113, y: p1.y - shape.width * 0.234)
        let p6 = CGPoint(x: p4.x - shape.width * 0.137, y: p4.y - shape.height * 0.431)
        let p7 = CGPoint(x: p1.x, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.313, y: p7.y - shape.height)
        let p9 = CGPoint(x: p1.x + shape.width * 0.268, y: p6.y - shape.width * 0.713)
        // Drawing
        draw(p1, 90, (value >= 1))
        draw(p2, 0, (value >= 2))
        draw(p3, 0, (value >= 3))
        draw(p4, 45, (value >= 4))
        draw(p5, -45, (value >= 5))
        draw(p6, -45, (value >= 6))
        draw(p7, 90, (value >= 7))
        draw(p8, 90, (value >= 9))
        draw(p9, 45, (value >= 8))
    }
    
    // MARK:- Drawing
    
    func drawPredatorLine(in context: CGContext, point: CGPoint, shape: CGSize, angle: CGFloat, enabled: Bool) {
        context.saveGState()
        var color = CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
        if !enabled {
            color = CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.3)
        }
        context.rotate(point, angle: angle)
        context.setFillColor(color)
        context.setStrokeColor(CGColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0))
        context.setShadow(offset: .zero, blur: 10.0, color: color)
        context.addPath(self.buildPredatorShapePath(in: CGRect(
            x: point.x,
            y: point.y,
            width: shape.width,
            height: shape.height
        )))
        context.closePath()
        context.fillPath()
        if !enabled {
            context.addPath(self.buildPredatorShapePath(in: CGRect(
                x: point.x,
                y: point.y,
                width: shape.width,
                height: shape.height
            )))
            context.closePath()
            context.strokePath()
        }
        context.restoreGState()
    }
    
    // MARK:- Number Paths
    
    func buildPredatorShapePath(in rect: CGRect) -> CGPath {
        let path = CGMutablePath()
        path.move(to: CGPoint(
            x: rect.origin.x,
            y: rect.origin.y + rect.size.height / 2.0
        ))
        path.addLine(to: CGPoint(
            x: rect.origin.x + rect.size.width * 0.1,
            y: rect.origin.y + rect.size.height
        ))
        path.addLine(to: CGPoint(
            x: rect.origin.x + rect.size.width * 0.9,
            y: rect.origin.y + rect.size.height
        ))
        path.addLine(to: CGPoint(
            x: rect.origin.x + rect.size.width,
            y: rect.origin.y + rect.size.height / 2.0
        ))
        path.addLine(to: CGPoint(
            x: rect.origin.x + rect.size.width * 0.9,
            y: rect.origin.y
        ))
        path.addLine(to: CGPoint(
            x: rect.origin.x + rect.size.width * 0.1,
            y: rect.origin.y
        ))
        path.addLine(to: CGPoint(
            x: rect.origin.x,
            y: rect.origin.y + rect.size.height / 2.0
        ))
        return path
    }
}

// MARK:- CGContext Extension

extension CGContext {
    
    func rotate(_ anchor: CGPoint, angle: CGFloat) {
        translateBy(x: anchor.x, y: anchor.y)
        rotate(by: angle * CGFloat.pi / 180)
        translateBy(x: -anchor.x, y: -anchor.y)
    }
}
