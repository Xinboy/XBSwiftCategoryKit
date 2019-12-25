//
//  IntExtensions.swift
//  CryptoSwift
//
//  Created by Xinbo Hong on 2019/7/5.
//

import Foundation

extension Int {
    /// 是否是偶数
    var isEven: Bool { return (self % 2 == 0) }
    /// 是否是奇数
    var isOdd: Bool { return (self % 2 != 0) }
    /// 是否是正数
    var isPositive: Bool { return (self > 0) }
    /// 是否是负数
    var isNegative: Bool { return (self < 0) }
    
    var toNumber: NSNumber { return NSNumber.init(value: self)}
    var toDouble: Double { return Double(self) }
    var toFloat: Float { return Float(self) }
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toString: String { return String(self)}
    var toUInt: UInt { return UInt(self) }
    var toInt32: Int32 { return Int32(self) }
    var toRange: CountableRange<Int> { return 0..<self }
    
    //获取该整数的位数
    var digits: Int {
        if self == 0 {
            return 1
        } else if Int(fabs(Double(self))) <= LONG_MAX {
            return Int(log10(fabs(Double(self)))) + 1
        } else {
            return -1 //out of bound
        }
    }
    
    //获取各位数的数组
    var digitArray: [Int] {
        var digits = [Int]()
        for char in self.toString {
            if let digit = Int(String(char)) {
                digits.append(digit)
            }
        }
        return digits
    }
    
    //获取在 [min, max] 范围内的随机整数，包括在内。
    static func random(within: Range<Int>) -> Int {
        let delta = within.upperBound - within.lowerBound
        return within.lowerBound + Int(arc4random_uniform(UInt32(delta)))
    }
}


extension UInt {

    public var toInt: Int { return Int(self) }
    
    /// 使用Euclid算法的两个整数的最大公约数。
    public static func gcd(_ firstNum: UInt, _ secondNum: UInt) -> UInt {
        let remainder = firstNum % secondNum
        if remainder != 0 {
            return gcd(secondNum, remainder)
        } else {
            return secondNum
        }
    }
    
    /// 两个数字的最小公倍数。 LCM = n * m / gcd（n，m）
    public static func lcm(_ firstNum: UInt, _ secondNum: UInt) -> UInt {
        return firstNum * secondNum / UInt.gcd(firstNum, secondNum)
    }
}
