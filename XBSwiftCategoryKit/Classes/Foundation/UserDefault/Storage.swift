//
//  Storage.swift
//  Pods-XBSwiftCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/10.
//

import Foundation

extension Key {
    static let name: Key = "name"
}

struct Storage {
    @UserDefault(key: .name)
    var name: Bool
}
