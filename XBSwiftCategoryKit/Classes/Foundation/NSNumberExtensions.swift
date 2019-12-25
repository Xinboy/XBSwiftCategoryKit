//
//  NSNumberExtensions.swift
//  CryptoSwift
//
//  Created by Xinbo Hong on 2019/7/11.
//

import Foundation

extension NSNumber {
    
    //根据最大位数digit，四舍五入
    func round(digit: Int) -> NSNumber {
        let formatter = NumberFormatter.init()
        formatter.roundingMode = .halfUp
        formatter.maximumFractionDigits = digit
        formatter.minimumFractionDigits = digit
        
        return NSNumber.init(value: (formatter.string(from: self)?.toNumber().doubleValue)!)
    }
    
    func ceil(digit: Int) -> NSNumber {
        let formatter = NumberFormatter.init()
        formatter.roundingMode = .ceiling
        formatter.maximumFractionDigits = digit
        
        return NSNumber.init(value: (formatter.string(from: self)?.toNumber().doubleValue)!)
    }
    
    func floor(digit: Int) -> NSNumber {
        let formatter = NumberFormatter.init()
        formatter.roundingMode = .floor
        formatter.maximumFractionDigits = digit
        
        return NSNumber.init(value: (formatter.string(from: self)?.toNumber().doubleValue)!)
    }


}
