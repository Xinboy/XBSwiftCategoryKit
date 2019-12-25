//
//  XB_Functions.swift
//  SwiftSpecsTest
//
//  Created by Xinbo Hong on 2019/7/17.
//  Copyright © 2019 com.xinbo.pro. All rights reserved.
//

import Foundation
import UIKit
import Photos

/// 控制台输出，输出内容：文件[行数]，方法：信息
func ck_print<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName)[\(line)], \(method): \(message)")
    #endif
    
}


/// 判断当前环境是否是生产环境
func isDistribution() ->  Bool {
    var isDis = true
    #if DEBUG
    isDis = false
    #endif
    return isDis
}

/// 语言本地化
func localizedString(_ key: String) -> String {
    let word = NSLocalizedString(key, comment: "")
    
    return word
}


/// 显示下弹提醒框
func showAlertController(title: String,leftTitle: String?, rightTitle: String?, doneAction: DoneClosure?) {
    let alertVC = UIAlertController.init(title: title, message: "", preferredStyle: .alert)
    if let leftTitle = leftTitle {
        alertVC.addAction(UIAlertAction.init(title: leftTitle, style: UIAlertAction.Style.default, handler: { (action) in
            doneAction?(0)
        }))
    }
    if let rightTitle = rightTitle {
        alertVC.addAction(UIAlertAction.init(title: rightTitle, style: UIAlertAction.Style.default, handler: { (action) in
            doneAction?(1)
        }))
    }
    currentVC().present(alertVC, animated: true, completion: nil)
}


/// 显示下弹提醒框，默认显示左边“取消”，右边“确定”，doneAction根据0，1判断事件
func showAlertController(title: String, doneAction: DoneClosure?) {
    let alertVC = UIAlertController.init(title: title, message: "", preferredStyle: .alert)
    alertVC.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.default, handler: { (action) in
        doneAction?(0)
    }))
    alertVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default, handler: { (action) in
        doneAction?(1)
    }))
    currentVC().present(alertVC, animated: true, completion: nil)
}

/// 显示下弹提醒框，传入根据index判断的闭包
func showSheetAlertController(textArray: Array<String>, doneAction: DoneClosure?) {
    let alertVC = UIAlertController()//.init(title: "", message: "", preferredStyle: .actionSheet)
    var index = 0
    for text in textArray {
        let action = UIAlertAction.init(title: text, style: UIAlertAction.Style.default, handler: { (action) in
            doneAction?(textArray.index(of: action.title!))
        })
        alertVC.addAction(action)
        if text == "删除" {
            action.setValue(UIColor.red, forKey: "titleTextColor")
        }
        index += 1
    }
    alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
        //        alertVC.dismiss(animated: true, completion: nil)
    }))
    
    currentVC().present(alertVC, animated: true, completion: nil)
}


/// 相机、相册选项弹出框，传入根据index判断的闭包
func cameraSheetShow(_ doneAction: DoneClosure?) {
    showSheetAlertController(textArray: ["相机", "相册"], doneAction: doneAction)
}

func currentVC() -> UIViewController {
    let window = UIApplication.shared.keyWindow
    var VC = window?.rootViewController
    VC = VC?.children.first
    if (VC?.isKind(of: UINavigationController.self))! {
        let nav = VC as? UINavigationController
        VC = nav?.children.last
        if (VC?.isKind(of: UITabBarController.self))! {
            let tab = VC as? UITabBarController
            VC = tab?.viewControllers![(tab?.selectedIndex)!]
        }
    }
    return VC!
}



