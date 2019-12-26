//
//  NSDictionaryExtension.swift
//  Pods-XBSwiftCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/25.
//

import Foundation
import UIKit

extension Dictionary {
    
    /// 字典转成JSON字符串数据
    var jsonString: String {
        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    
        
        return String(data: jsonData, encoding: .utf8)!
    }

}
