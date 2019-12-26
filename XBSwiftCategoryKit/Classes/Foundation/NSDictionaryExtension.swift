//
//  NSDictionaryExtension.swift
//  Pods-XBSwiftCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/25.
//

import Foundation

extension NSDictionary {
    
    /// 字典转成JSON字符串数据
    var jsonString: String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        
        return String(data: jsonData!, encoding: .utf8)
    }

    /// 打印Model所需要的属性代码: 可以利用该方法获取Model的属性参数
    class func propertyCode() {
        
    }
    
}
