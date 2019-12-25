//
//  XBConstant.swift
//  SwiftSpecsTest
//
//  Created by Xinbo Hong on 2019/7/17.
//  Copyright © 2019 com.xinbo.pro. All rights reserved.
//

import UIKit
import Foundation

// MARK: - 尺寸有关
/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.size.width
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.size.height
/// 宽度比例：以6为标准比例缩放
var kScreenWidthScale: CGFloat {
    return kScreenWidth / 375.0
}
/// 高度比例：以6为标准比例缩放
var kScreenHeightScale: CGFloat {
    return kScreenHeight / 667.0
}
/// 高宽比例：以6为标准比例缩放
var kScreenSideScale: CGFloat {
     return (kScreenHeight / kScreenWidth) / 1.779;
}
/// 导航栏高度
let kNavHeight = CGFloat(44.0)
/// 状态栏高度
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

/// 底部危险区域高度，X特有
//let kBottomDangerHeight = UIDevice.isXSeriesSizeOfiPhone() ? CGFloat(34.0) : CGFloat(0.0)
/// 顶部总高度
let kMainHeight = kNavHeight + kStatusBarHeight
/// 底部菜单栏
let kTarBarHeight = CGFloat(49.0)
/// 主要分辨率
let kMainScale = UIScreen.main.scale
/// 0高度
let kZeroHeight = CGFloat(0.000001)

// MARK: - INFO
/// 本地App版本
let kAppVersion =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
/// 系统版本
let kSystemVersion = UIDevice.current.systemVersion
/// UUID
let kDeviceUUID = UIDevice.current.identifierForVendor?.uuidString
/// 二维码前缀，标识为XXX
let codePrefix = "XB-"

// MARK: - 通用闭包
/// 带参数的闭包，主要用于回调
typealias CallBackClosure = (_ obj: Any?) -> Void

/// 带index的闭包，可用于用index区分的事件集中
typealias DoneClosure = (_ index: Int) -> ()


// MARK: - 请求地址以及第三方集成相关，分为开发模式，测试模式，生产模式
#if DEVELOPER
let JMessageAppKey = "xxxxx"
let JPushAppKey = "xxxxx"
/// 项目请求地址
let httpHost = "xxxxx"
///阿里云域名
let endPoint = "xxxxx"
///阿里云bucketname
let bucketname = "xxxxx"
///获取图片的URL地址
let imageHost = "xxxxx"
///高德地图key
let AMapKey = "xxxxx"

#elseif TEST
let JMessageAppKey = "xxxxx"
let JPushAppKey = "xxxxx"
/// 项目请求地址
let httpHost = "xxxxx"
///阿里云域名
let endPoint = "xxxxx"
///阿里云bucketname
let bucketname = "xxxxx"
///获取图片的URL地址
let imageHost = "xxxxx"
///高德地图key
let AMapKey = "xxxxx"

#elseif RELEASE
let JMessageAppKey = "xxxxx"
let JPushAppKey = "xxxxx"
/// 项目请求地址
let httpHost = "xxxxx"
///阿里云域名
let endPoint = "xxxxx"
///阿里云bucketname
let bucketname = "xxxxx"
///获取图片的URL地址
let imageHost = "xxxxx"
///高德地图key
let AMapKey = "xxxxx"
#endif

///微信keys
let WechatAppKey = "xxxxx"
let WechatSecret = "xxxxx"
