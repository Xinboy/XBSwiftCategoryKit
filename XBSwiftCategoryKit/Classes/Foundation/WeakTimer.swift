//
//  WeakTimer.swift
//  SwiftEditProject
//
//  Created by Xinbo Hong on 2019/12/26.
//  Copyright © 2019 com.xinbo. All rights reserved.
//

import UIKit
import Foundation


//Block模型类
class Block<T> {
    let type: T
    init(_ type: T) {
        self.type = type
    }
}

extension Timer {
    
    /// 防止 Timer 循环引用
    class func xb_scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Swift.Void) -> Timer {
        
        if UIDevice.current.systemVersion.toFloat()! >= 10.0 {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        }

        return scheduledTimer(timeInterval: interval, target: self, selector: #selector(xx_handerTimerAction(_:)), userInfo: Block(block), repeats: true)

    }
    
    // 一定要加class。 Timer是类对象，只能调用类方法，不能调用实例方法
    @objc class func xx_handerTimerAction(_ sender: Timer) {
        if let block = sender.userInfo as? Block<(Timer) -> Void> {
            block.type(sender)
        }
    }
}



