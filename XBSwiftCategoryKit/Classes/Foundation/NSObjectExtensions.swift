//
//  NSObjectExtensions.swift
//  XBSwiftCategoryKit
//
//  Created by Xinbo Hong on 2019/7/5.
//

import Foundation

extension NSObject {
    /// 当前类名称
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    /// 父类名称
    var superClassName: String {
        return type(of: self).superClassName
    }
    
    static var superClassName: String {
        return String(describing: self.superclass())
    }
}
