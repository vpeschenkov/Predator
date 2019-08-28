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

import Cocoa
import QuartzCore

// MARK: - Predator Clock Screen Saver

final public class PredatorClock {
    public var configuration: Configuration
    
    public init(with configuration: Configuration) {
        self.configuration = configuration
    }
    
    public func draw(in rect: CGRect, context: CGContext) {
        // Time
        let date = Date()
        let calendar = Calendar.current
        var hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        // Converts time to 12-hour clock format
        if configuration.twelveHours {
            hours = hours > 12 ? hours - 12 : hours
            hours = hours == 0 ? 12 : hours
        }
        
        let width = min(rect.size.width, rect.size.height) * 0.25
        let height = width * 1.5
        let center = CGPoint(x: rect.width / 2.0, y: rect.height / 2.0)
        let nummberSize = CGSize(width: width, height: height)
        drawHourHightNumber(in: CGRect(
            x: center.x - nummberSize.width * 2.0,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(hours / 10))
        drawHourLowNumber(in: CGRect(
            x: center.x - nummberSize.width,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(hours % 10))
        drawMinuteHightNumber(in: CGRect(
            x: center.x,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(minutes / 10))
        drawMinuteLowNumber(in: CGRect(
            x: center.x + nummberSize.width,
            y: center.y - nummberSize.height / 2.0,
            width: nummberSize.width,
            height: nummberSize.height
        ), context: context, value: Int(minutes % 10))
        if configuration.twelveHours {
            drawClockFormat(in: CGRect(
                x: center.x + nummberSize.width * 2.0,
                y: center.y - nummberSize.height / 2.0,
                width: nummberSize.width,
                height: nummberSize.height
            ), context: context, value: Int(hours % 12))
        }
    }
    
    // MARK: - Hours
    
    func drawHourHightNumber(in rect: CGRect, context: CGContext, value: Int) {
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
        let p7 = CGPoint(x: p1.x - shape.width * 0.068, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.237, y: p7.y - shape.height)
        let p9 = CGPoint(x: p1.x + shape.width * 0.268, y: p6.y - shape.width * 0.713)
        // Drawing
        let isEnabled = { (value: Int,  part: Int) -> Bool in
            if self.configuration.twentyFourHours {
                if value >= part {
                    return true
                }
                return false
            }
            return value >= 1
        }
        draw(p1, 90, isEnabled(value, 1))
        draw(p2, 0, isEnabled(value, 1))
        draw(p3, 0, isEnabled(value, 1))
        draw(p4, 45, isEnabled(value, 1))
        draw(p5, -45, isEnabled(value, 1))
        draw(p6, -45, isEnabled(value, 2))
        draw(p7, 90, isEnabled(value, 2))
        draw(p8, 90, isEnabled(value, 2))
        draw(p9, 45, isEnabled(value, 2))
    }
    
    func drawHourLowNumber(in rect: CGRect, context: CGContext, value: Int) {
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
        let p7 = CGPoint(x: p1.x - shape.width * 0.068, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.237, y: p7.y - shape.height)
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
    
    // MARK: - Minutes
    
    func drawMinuteHightNumber(in rect: CGRect, context: CGContext, value: Int) {
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
        let p7 = CGPoint(x: p1.x - shape.width * 0.068, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.237, y: p7.y - shape.height)
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
    
    func drawMinuteLowNumber(in rect: CGRect, context: CGContext, value: Int) {
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
        let p7 = CGPoint(x: p1.x - shape.width * 0.068, y: p6.y - shape.width * 1.543)
        let p8 = CGPoint(x: p1.x + shape.width * 0.237, y: p7.y - shape.height)
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
    
    // MARK: - AM/PM
    
    func drawClockFormat(in rect: CGRect, context: CGContext, value: Int) {
        let width = rect.size.width * 0.384
        let height = width * 0.2
        let shape = CGSize(width: width, height: height)
        let center = CGPoint(x: rect.origin.x + rect.width / 2.0, y: rect.origin.y + rect.height / 2.0)
        let draw = { (point: CGPoint, angle: CGFloat, enabled: Bool) in
            self.drawPredatorLine(in: context, point:point, shape: shape, angle:angle, enabled: enabled)
        }
        // Define lines
        let p1 = CGPoint(x: center.x - shape.width, y: rect.origin.y + rect.height)
        // Drawing
        draw(p1, -45, (value >= 1))
    }
    
    // MARK: - Drawing
    
    func drawPredatorLine(in context: CGContext, point: CGPoint, shape: CGSize, angle: CGFloat, enabled: Bool) {
        if configuration.drawEmptyDigits || enabled {
            var color = configuration.primaryColor.cgColor
            let reverse = configuration.reverse == true ? !enabled : enabled
            context.saveGState()
            if reverse == false  {
                color = color.copy(alpha: 0.3) ?? color
            }
            context.rotate(point, angle: angle)
            context.setFillColor(color)
            context.setStrokeColor(color.copy(alpha: 1.0) ?? color)
            context.setShadow(offset: .zero, blur: 10.0, color: color)
            context.addPath(self.buildPredatorShapePath(in: CGRect(
                x: point.x,
                y: point.y,
                width: shape.width,
                height: shape.height
            )))
            context.closePath()
            context.fillPath()
            if reverse == false {
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
    }
    
    // MARK: - Number Paths
    
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

// MARK: - CGContext Extension

extension CGContext {
    
    func rotate(_ anchor: CGPoint, angle: CGFloat) {
        translateBy(x: anchor.x, y: anchor.y)
        rotate(by: angle * CGFloat.pi / 180)
        translateBy(x: -anchor.x, y: -anchor.y)
    }
}
