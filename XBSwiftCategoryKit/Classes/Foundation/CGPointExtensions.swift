//
//  CGPointExtensions.swift
//  CryptoSwift
//
//  Created by Xinbo Hong on 2019/7/4.
//

import Foundation

extension CGPoint {
    
    /// 由点表示的角度值
    var angle: CGFloat {
        return atan2(y, x)
    }

    /// 由点表示的角度
    ///
    /// - Parameter angle: 由点表示的角度
    init(angle: CGFloat) {
        self.init(x: cos(angle), y: sin(angle))
    }
    
    
    /// 针对点重写加号
    ///
    /// - Parameters:
    ///   - this: 加数1
    ///   - that: 加数2
    /// - Returns: 两点相加的结果
    static func + (this: CGPoint, that: CGPoint) -> CGPoint {
         return CGPoint(x: this.x + that.x, y: this.y + that.y)
    }
    
    /// 针对点重写减号
    ///
    /// - Parameters:
    ///   - this: 被减数
    ///   - that: 减数
    /// - Returns: 两点相减的结果
    static func - (this: CGPoint, that: CGPoint) -> CGPoint {
        return CGPoint(x: this.x - that.x, y: this.y - that.y)
    }

    
    /// 针对点的乘数
    ///
    /// - Parameters:
    ///   - point: 被乘数
    ///   - scalar: 乘数
    /// - Returns: 点和数相乘结果
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    
    /// 两点之间的距离
    ///
    /// - Parameters:
    ///   - from: 起始点
    ///   - to: 终点
    /// - Returns: 两点之间的距离数
    static func distance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(pow(to.x - from.x, 2) + pow(to.y - from.y, 2))
    }
    
    
    // MARK: - 用点表示的向量相关的操作
    /// 由点表示的向量
    init(vector: CGVector) {
        self.init(x: vector.dx, y: vector.dy)
    }
    
    /// 将CGPoint描述的向量规范化为长度1.0，并将结果作为新的CGPoint返回
    func normalized() -> CGPoint {
        let len = CGPoint.distance(from: self, to: CGPoint.zero)
        return CGPoint(x: self.x / len, y: self.y / len)
    }
    
    /// 由点表示的两个向量的点积
    static func dotProduct(this: CGPoint, that: CGPoint) -> CGFloat {
        return this.x * that.x + this.y * that.y
    }
    
    /// 在两个CGPoint值之间执行线性插值。
    static func linearInterpolation(startPoint: CGPoint, endPoint: CGPoint, interpolationParam: CGFloat) -> CGPoint {
        return startPoint + (endPoint - startPoint) * interpolationParam
    }
    
    
}
