//
//  ArrayExtensions.swift
//  CryptoSwift
//
//  Created by Xinbo Hong on 2019/7/11.
//

import Foundation


public func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}


extension Array where Element: Hashable {
    
    /// 根据index获取元素
    func get(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }
    
    /// 向首部加入元素
    mutating func insertFirst(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    
    /// 删除首个指定元素
    mutating func removeObject(_ obj: Element){
        let index = self.index(of: obj)
        if index <= self.count && index > 0 {
            self.remove(at: index)
        }
    }
    
    /// 获取指定元素首个index
    func index(of obj: Element) -> Int {
        
        let index = self.firstIndex { (item) -> Bool in
            if (item as AnyObject).isEqual(obj) {
                return true
            }
            return false
        }
        
        if index == nil {
            return -1
        }
        return index!
    }
    
    /// 没有重复数据的数组
    var unique:[Element] {
        var uniq = Set<Element>()
        uniq.reserveCapacity(self.count)
        return self.filter {
            return uniq.insert($0).inserted
        }
    }
}
