//
//  NSAttributedStringExtensions.swift
//  CryptoSwift
//
//  Created by Xinbo Hong on 2019/7/5.
//

import Foundation
import UIKit

extension NSAttributedString {
    /// 加粗
    func bold() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }
    
    /// 底部线
    func underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        return copy
    }
    
    /// 斜体
    func italic() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }
    
    /// 删除线
    func strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)]
        copy.addAttributes(attributes, range: range)
        
        return copy
    }
    
    /// 设置字体颜色
    func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        
        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }
}

/// 文本后方加入新的富文本字符串：
func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}

/// 两富文本字符串相加：
func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    return ns
}
