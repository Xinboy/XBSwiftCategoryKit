//
//  CGFloatExtensions.swift
//  XBSwiftCategoryKit
//
//  Created by Xinbo Hong on 2019/7/4.
//

import Foundation

public extension CGFloat {
    
    /// 当前数值的一半
    var half: CGFloat { return (self / 2) }
    
    /// 角度转弧度
    func degreesToRadians() -> CGFloat {
        return (.pi * self) / 180.0
    }
    
    /// 角度转弧度
    static func degreesToRadians(angle: CGFloat) -> CGFloat {
        return (.pi * angle) / 180.0
    }
    
    /// 角度转弧度
    mutating func degreesToRadians() {
        self = (.pi * self) / 180.0
    }
    
    
    /// 弧度转角度
    func radiansToDegrees() -> CGFloat {
        return (180.0 * self) / .pi
    }
    
    /// 弧度转角度
    mutating func radiansToDegrees() {
        self = (180.0 * self) / .pi
    }
    
    static func radiansToDegrees(radians: CGFloat) -> CGFloat {
        return (180.0 * radians) / .pi
    }
    
    var random: CGFloat {
        return CGFloat.random()
    }
    
    /// 随机数
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /// 开区间随机数
    static func random(within: Range<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// 闭区间随机数
    static func random(within: ClosedRange<CGFloat>) -> CGFloat {
        return CGFloat.random() * (within.upperBound - within.lowerBound) + within.lowerBound
    }
    
    /// 获取最小角度的弧度
    static func shortestAngleInRadians(from first: CGFloat, to second: CGFloat) -> CGFloat {
        let twoPi = CGFloat(.pi * 2.0)
        var angle = (second - first).truncatingRemainder(dividingBy: twoPi)
        if angle >= .pi {
            angle -= twoPi
        }
        if angle <= -.pi {
            angle += twoPi
        }
        return angle
    }
}
