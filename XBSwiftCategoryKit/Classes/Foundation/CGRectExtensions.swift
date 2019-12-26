//
//  CGRectExtensions.swift
//  CryptoSwift
//
//  Created by Xinbo Hong on 2019/7/4.
//

import Foundation
import UIKit

public extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        }
        set(value) {
            self.origin.x = value
        }
    }
    
    var y: CGFloat {
        get {
            return self.origin.y
        }
        set(value) {
            self.origin.y = value
        }
    }
    
    var w: CGFloat {
        get {
            return self.size.width
        }
        set(value) {
            self.size.width = value
        }
    }
    
    var h: CGFloat {
        get {
            return self.size.height
        }
        set(value) {
            self.size.height = value
        }
    }
    
    /// 面积
    var area: CGFloat { return self.h * self.w }
    
    /// 宽度的一半
    var midW: CGFloat { return self.w * 0.5 }
    
    /// 长度的一半
    var midH: CGFloat { return self.h * 0.5 }
    
    /// 中间坐标
    var mid: CGPoint { return CGPoint.init(x: self.midX, y: self.midY)}
}
