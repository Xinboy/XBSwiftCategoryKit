//
//  BundleExtensions.swift
//  XBSwiftCategoryKit
//
//  Created by Xinbo Hong on 2019/7/4.
//

import Foundation

public extension Bundle {
    
    //  设置Xib子视图
    //  使用方式：
    //  Bundle.loadNib("ViewXibName", owner: self)
    //  self.addSubview(self.contentView)
    class func loadNib(_ name:String, owner: Any!) {
        _ = Bundle.main.loadNibNamed(name, owner: owner, options: nil)?[0]
    }
    
    // 加载Xib子视图
    // 使用方式:
    // let view: ViewXibName = Bundle.loadNib("ViewXibName")
    class func loadNib<T>(name: String) -> T? {
        return  Bundle.main.loadNibNamed(name, owner: nil, options: nil)?[0] as? T
    }
}
