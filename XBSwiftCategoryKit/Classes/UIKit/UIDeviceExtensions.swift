//
//  UIDeviceExtensions.swift
//  Pods-XBSwiftCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/10.
//

import Foundation
import UIKit
// MARK: - iPhone
extension UIDevice {
    enum PhoneType: Int {
        case iPhoneUnknown
        case iPhone4
        case iPhone4s
        case iPhone5
        case iPhone5c
        case iPhone5s
        case iPhone6
        case iPhone6Plus
        case iPhone6s
        case iPhone6sPlus
        case iPhone7
        case iPhone7Plus
        case iPhoneSE
        //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
        case iPhone8
        case iPhone8Plus
        case iPhoneX
        //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
        case iPhoneXs
        case iPhoneXsMax
        case iPhoneXr
        //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
        case iPhone11
        case iPhone11Pro
        case iPhone11ProMax
    }
    
    private class func platform() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    private class func iPhonePlatform() -> PhoneType {
        
        let identifier = UIDevice.platform()

        if ["iPhone3,1", "iPhone3,2", "iPhone3,3"].contains(identifier) { return .iPhone4 }
        if ["iPhone4,1"].contains(identifier) { return .iPhone4s }
        if ["iPhone5,1", "iPhone5,2"].contains(identifier) { return .iPhone5 }
        if ["iPhone5,3", "iPhone5,4"].contains(identifier) { return .iPhone5c }
        if ["iPhone6,1", "iPhone6,2"].contains(identifier) { return .iPhone5s }
        if ["iPhone7,2"].contains(identifier) { return .iPhone6 }
        if ["iPhone7,1"].contains(identifier) { return .iPhone6Plus }
        if ["iPhone8,1"].contains(identifier) { return .iPhone6s }
        if ["iPhone8,2"].contains(identifier) { return .iPhone6sPlus }
        if ["iPhone9,1", "iPhone9,3"].contains(identifier) { return .iPhone7 }
        if ["iPhone9,2", "iPhone9,4"].contains(identifier) { return .iPhone7Plus }
        if ["iPhone8,4"].contains(identifier) { return .iPhoneSE }
        //2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
        if ["iPhone10,1", "iPhone10,4"].contains(identifier) { return .iPhone8 }
        if ["iPhone10,2", "iPhone10,5"].contains(identifier) { return .iPhone8Plus }
        if ["iPhone10,3", "iPhone10,6"].contains(identifier) { return .iPhoneX }
        //2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
        if ["iPhone11,2"].contains(identifier) { return .iPhoneXs }
        if ["iPhone11,4", "iPhone11,6"].contains(identifier) { return .iPhoneXsMax }
        if ["iPhone11,8"].contains(identifier) { return .iPhoneXr }
        //2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
        if ["iPhone12,1"].contains(identifier) { return .iPhone11 }
        if ["iPhone12,3"].contains(identifier) { return .iPhone11Pro }
        if ["iPhone12,5"].contains(identifier) { return .iPhone11ProMax }
        return .iPhoneUnknown
    }
    
    class func iPhoneDescription(platform: String) -> String {
        let type = UIDevice.iPhonePlatform()
        switch type {
        case .iPhone4: return "iPhone4"
        case .iPhone4s: return "iPhone4s"
        case .iPhone5: return "iPhone5"
        case .iPhone5c: return "iPhone5c"
        case .iPhone5s: return "iPhone5s"
        case .iPhone6: return "iPhone6"
        case .iPhone6Plus: return "iPhone6Plus"
        case .iPhone6s: return "iPhone6s"
        case .iPhone6sPlus: return "iPhone6sPlus"
        case .iPhone7: return "iPhone7"
        case .iPhone7Plus: return "iPhone7Plus"
        case .iPhoneSE: return "iPhoneSE"
        case .iPhone8: return "iPhone8"
        case .iPhone8Plus: return "iPhone8Plus"
        case .iPhoneX: return "iPhoneX"
        case .iPhoneXs: return "iPhoneXs"
        case .iPhoneXsMax: return "iPhoneXsMax"
        case .iPhoneXr: return "iPhoneXr"
        case .iPhone11: return "iPhone11"
        case .iPhone11Pro: return "iPhone11Pro"
        case .iPhone11ProMax: return "iPhone11ProMax"
        case .iPhoneUnknown: return "Unknown"
        }
        
    }
    
    class func isPhone() -> Bool {
        let platform = UIDevice.platform()
        
        if platform.contains("iPhone") {
            return true
        }
        return false
        
    }
//
//    private class func deviceFromDeviceIdentifier(_ platform: String) -> DeviceType {
//        /** iPod*/
//        if ["iPod5,1"].contains(platform) { return DeviceType.iPodTouch5 }
//        if ["iPod7,1"].contains(platform) { return DeviceType.iPodTouch6 }
//
//        /** iPad*/
//        if ["iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4"].contains(platform) { return DeviceType.iPad2 }
//        if ["iPad3,1", "iPad3,2", "iPad3,3"].contains(platform) { return DeviceType.iPad3 }
//        if ["iPad3,4", "iPad3,5", "iPad3,6"].contains(platform) { return DeviceType.iPad4 }
//        if ["iPad4,1", "iPad4,2", "iPad4,3"].contains(platform) { return DeviceType.iPadAir }
//        if ["iPad5,3", "iPad5,4"].contains(platform) { return DeviceType.iPadAir2 }
//        if ["iPad6,11", "iPad6,12"].contains(platform) { return DeviceType.iPad5 }
//        if ["iPad7,5", "iPad7,6"].contains(platform) { return DeviceType.iPad6 }
//        if ["iPad2,5", "iPad2,6", "iPad2,7"].contains(platform) { return DeviceType.iPadMini }
//        if ["iPad4,4", "iPad4,5", "iPad4,6"].contains(platform) { return DeviceType.iPadMini2 }
//        if ["iPad4,7", "iPad4,8", "iPad4,9"].contains(platform) { return DeviceType.iPadMini3 }
//        if ["iPad5,1", "iPad5,2"].contains(platform) { return DeviceType.iPadMini4 }
//        if ["iPad6,3", "iPad6,4"].contains(platform) { return DeviceType.iPadPro9Inch }
//        if ["iPad6,7", "iPad6,8"].contains(platform) { return DeviceType.iPadPro12Inch }
//        if ["iPad7,1", "iPad7,2"].contains(platform) { return DeviceType.iPadPro12Inch2 }
//        if ["iPad7,3", "iPad7,4"].contains(platform) { return DeviceType.iPadPro10Inch }
//
//        if ["i386", "x86_64"].contains(platform) {
//            let temp: String = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"]!
//            return UIDevice.deviceFromDeviceIdentifier(temp)
//        }
//
//        return DeviceType.Unknown
//    }
//
//    private  class func currentDevice() -> DeviceType {
//        return UIDevice.deviceFromDeviceIdentifier(UIDevice.platformWithCurrentDevice())
//    }
//
//    // MARK: - Info With Difference Device
//    class func diagonalWithDevice() -> CGFloat {
//        let type = UIDevice.currentDevice()
//        switch type {
//        case .iPodTouch5: return 4.0
//        case .iPodTouch6: return 4.0
//        case .iPhone4: return 3.5
//        case .iPhone4s: return 3.5
//        case .iPhone5: return 4.0
//        case .iPhone5c: return 4.0
//        case .iPhone5s: return 4.0
//        case .iPhone6: return 4.7
//        case .iPhone6Plus: return 5.5
//        case .iPhone6s: return 4.7
//        case .iPhone6sPlus: return 5.5
//        case .iPhone7: return 4.7
//        case .iPhone7Plus: return 5.5
//        case .iPhoneSE: return 4.0
//        case .iPhone8: return 4.7
//        case .iPhone8Plus: return 5.5
//        case .iPhoneX: return 5.8
//        case .iPhoneXs: return 5.8
//        case .iPhoneXsMax: return 6.5
//        case .iPhoneXr: return 6.1
//        case .iPad2: return 9.7
//        case .iPad3: return 9.7
//        case .iPad4: return 9.7
//        case .iPadAir: return 9.7
//        case .iPadAir2: return 9.7
//        case .iPad5: return 9.7
//        case .iPad6: return 9.7
//        case .iPadMini: return 7.9
//        case .iPadMini2: return 7.9
//        case .iPadMini3: return 7.9
//        case .iPadMini4: return 7.9
//        case .iPadPro9Inch: return 9.7
//        case .iPadPro12Inch: return 12.9
//        case .iPadPro12Inch2: return 12.9
//        case .iPadPro10Inch: return 10.5
//        case .Simulator: return -1.0
//        case .Unknown: return -1.0
//        }
//    }
//
//    class func screenRatioWithDevice() -> CGSize {
//        let type = UIDevice.currentDevice()
//        switch type {
//        case .iPodTouch5: return CGSize.init(width: 9, height: 16)
//        case .iPodTouch6: return CGSize.init(width: 9, height: 16)
//        case .iPhone4: return CGSize.init(width: 2, height: 3)
//        case .iPhone4s: return CGSize.init(width: 2, height: 3)
//        case .iPhone5: return CGSize.init(width: 9, height: 16)
//        case .iPhone5c: return CGSize.init(width: 9, height: 16)
//        case .iPhone5s: return CGSize.init(width: 9, height: 16)
//        case .iPhone6: return CGSize.init(width: 9, height: 16)
//        case .iPhone6Plus: return CGSize.init(width: 9, height: 16)
//        case .iPhone6s: return CGSize.init(width: 9, height: 16)
//        case .iPhone6sPlus: return CGSize.init(width: 9, height: 16)
//        case .iPhone7: return CGSize.init(width: 9, height: 16)
//        case .iPhone7Plus: return CGSize.init(width: 9, height: 16)
//        case .iPhoneSE: return CGSize.init(width: 9, height: 16)
//        case .iPhone8: return CGSize.init(width: 9, height: 16)
//        case .iPhone8Plus: return CGSize.init(width: 9, height: 16)
//        case .iPhoneX: return CGSize.init(width: 9, height: 19.5)
//        case .iPhoneXs: return CGSize.init(width: 9, height: 19.5)
//        case .iPhoneXsMax: return CGSize.init(width: 9, height: 19.5)
//        case .iPhoneXr: return CGSize.init(width: 9, height: 19.5)
//        case .iPad2: return CGSize.init(width: 3, height: 4)
//        case .iPad3: return CGSize.init(width: 3, height: 4)
//        case .iPad4: return CGSize.init(width: 3, height: 4)
//        case .iPadAir: return CGSize.init(width: 3, height: 4)
//        case .iPadAir2: return CGSize.init(width: 3, height: 4)
//        case .iPad5: return CGSize.init(width: 3, height: 4)
//        case .iPad6: return CGSize.init(width: 3, height: 4)
//        case .iPadMini: return CGSize.init(width: 3, height: 4)
//        case .iPadMini2: return CGSize.init(width: 3, height: 4)
//        case .iPadMini3: return CGSize.init(width: 3, height: 4)
//        case .iPadMini4: return CGSize.init(width: 3, height: 4)
//        case .iPadPro9Inch: return CGSize.init(width: 3, height: 4)
//        case .iPadPro12Inch: return CGSize.init(width: 3, height: 4)
//        case .iPadPro12Inch2: return CGSize.init(width: 3, height: 4)
//        case .iPadPro10Inch: return CGSize.init(width: 3, height: 4)
//        case .Simulator: return CGSize.init(width: -1, height: -1)
//        case .Unknown: return CGSize.init(width: -1, height: -1)
//        }
//    }
//
//    class func ppiWithDevice() -> NSInteger {
//        let type = UIDevice.currentDevice()
//        switch type {
//        case .iPodTouch5: return 326
//        case .iPodTouch6: return 326
//        case .iPhone4: return 326
//        case .iPhone4s: return 326
//        case .iPhone5: return 326
//        case .iPhone5c: return 326
//        case .iPhone5s: return 326
//        case .iPhone6: return 326
//        case .iPhone6Plus: return 401
//        case .iPhone6s: return 326
//        case .iPhone6sPlus: return 401
//        case .iPhone7: return 326
//        case .iPhone7Plus: return 401
//        case .iPhoneSE: return 326
//        case .iPhone8: return 326
//        case .iPhone8Plus: return 401
//        case .iPhoneX: return 458
//        case .iPhoneXs: return 458
//        case .iPhoneXsMax: return 458
//        case .iPhoneXr: return 326
//        case .iPad2: return 132
//        case .iPad3: return 264
//        case .iPad4: return 264
//        case .iPadAir: return 264
//        case .iPadAir2: return 264
//        case .iPad5: return 264
//        case .iPad6: return 264
//        case .iPadMini: return 163
//        case .iPadMini2: return 326
//        case .iPadMini3: return 326
//        case .iPadMini4: return 326
//        case .iPadPro9Inch: return 264
//        case .iPadPro12Inch: return 264
//        case .iPadPro12Inch2: return 264
//        case .iPadPro10Inch: return 264
//        case .Simulator: return -1
//        case .Unknown: return -1
//        }
//    }
//
//    class func descriptionWithDevice() -> String {
//
//        //模拟器，如果需要在模拟器运行时输出对应的机型，请注释。
//        if ["i386", "x86_64"].contains(UIDevice.platformWithCurrentDevice()) {
//            return "Simulator"
//        }
//
//        let type = UIDevice.currentDevice()
//        switch type {
//        case .iPodTouch5: return "iPod Touch 5"
//        case .iPodTouch6: return "iPod Touch 6"
//        case .iPhone4: return "iPhone4"
//        case .iPhone4s: return "iPhone4s"
//        case .iPhone5: return "iPhone5"
//        case .iPhone5c: return "iPhone5c"
//        case .iPhone5s: return "iPhone5s"
//        case .iPhone6: return "iPhone6"
//        case .iPhone6Plus: return "iPhone6Plus"
//        case .iPhone6s: return "iPhone6s"
//        case .iPhone6sPlus: return "iPhone6sPlus"
//        case .iPhone7: return "iPhone7"
//        case .iPhone7Plus: return "iPhone7Plus"
//        case .iPhoneSE: return "iPhoneSE"
//        case .iPhone8: return "iPhone8"
//        case .iPhone8Plus: return "iPhone8Plus"
//        case .iPhoneX: return "iPhoneX"
//        case .iPhoneXs: return "iPhoneXs"
//        case .iPhoneXsMax: return "iPhoneXsMax"
//        case .iPhoneXr: return "iPhoneXr"
//        case .iPad2: return "iPad2"
//        case .iPad3: return "iPad35"
//        case .iPad4: return "iPad4"
//        case .iPadAir: return "iPadAir"
//        case .iPadAir2: return "iPadAir2"
//        case .iPad5: return "iPad5"
//        case .iPad6: return "iPad6"
//        case .iPadMini: return "iPadMini"
//        case .iPadMini2: return "iPadMini2"
//        case .iPadMini3: return "iPadMini3"
//        case .iPadMini4: return "iPadMini4"
//        case .iPadPro9Inch: return "iPadPro9Inch"
//        case .iPadPro12Inch: return "iPadPro12Inch"
//        case .iPadPro12Inch2: return "iPadPro12Inch2"
//        case .iPadPro10Inch: return "iPadPro10Inch"
//        case .Simulator: return "Simulator"
//        case .Unknown: return "Unknown"
//        }
//    }
//
//    // MARK: - Is Device Kinds of the Device?
//    class func isPod() -> Bool {
//        let type: DeviceType = UIDevice.currentDevice()
//        switch type {
//        case .iPodTouch5, .iPodTouch6:
//            return true
//        default:
//            return false
//        }
//    }
//
//    class func isPhone() -> Bool {
//        let type: DeviceType = UIDevice.currentDevice()
//        switch type {
//        case .iPhone4, .iPhone4s, .iPhone5, .iPhone5c, .iPhone5s, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhoneSE, .iPhone8, .iPhone8Plus, .iPhoneX, .iPhoneXs, .iPhoneXsMax, .iPhoneXr:
//            return true
//        default:
//            return false
//        }
//    }
//
//    class func isPad() -> Bool {
//        let type: DeviceType = UIDevice.currentDevice()
//        switch type {
//        case .iPad2, .iPad3, .iPad4, .iPadAir, .iPadAir2, .iPad5, .iPad6, .iPadMini, .iPadMini2, .iPadMini3, .iPadMini4, .iPadPro9Inch, .iPadPro12Inch, .iPadPro12Inch2, .iPadPro10Inch:
//            return true
//        default:
//            return false
//        }
//
//    }
//
//    class func isCanFaceID() -> Bool {
//        let type: DeviceType = UIDevice.currentDevice()
//        switch type {
//        case .iPhoneX, .iPhoneXs, .iPhoneXsMax, .iPhoneXr:
//            return true
//        default:
//            return false
//        }
//    }
//
//    class func isCanTouchID() -> Bool {
//        let type: DeviceType = UIDevice.currentDevice()
//        switch type {
//        case .iPhone5s, .iPhone6, .iPhone6Plus, .iPhone6s, .iPhone6sPlus, .iPhone7, .iPhone7Plus, .iPhoneSE, .iPhone8, .iPhone8Plus, .iPadAir2, .iPad5, .iPad6, .iPadMini3, .iPadMini4, .iPadPro9Inch, .iPadPro12Inch, .iPadPro12Inch2, .iPadPro10Inch:
//            return true
//        default:
//            return false
//        }
//    }
//
//    class func isRunningOniPhone() -> Bool {
//        return UI_USER_INTERFACE_IDIOM() == .phone
//    }
//
//    class func isRunningOniPad() -> Bool {
//        return UI_USER_INTERFACE_IDIOM() == .pad
//    }
//
//    //3.7/4英寸的iPhone
//    class func isSmallSizeOfiPhone() -> Bool {
//        let diagonal = UIDevice.diagonalWithDevice()
//        if diagonal <= 4 {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    //4.7英寸的iPhone
//    class func isDefaultSizeOfiPhone() -> Bool {
//        let diagonal = UIDevice.diagonalWithDevice()
//        if diagonal == 4.7 {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    //大英寸的iPhone
//    class func isPlusSizeOfiPhone() -> Bool {
//        let diagonal = UIDevice.diagonalWithDevice()
//        if diagonal > 4.6 && diagonal < 9.7 {
//            return true
//        } else {
//            return false
//        }
//    }
//
//    //iPhone X系列
//    class func isXSeriesSizeOfiPhone() -> Bool {
//        return UIDevice.isCanFaceID()
//    }
    

}

// MARK: - iPad
extension UIDevice {
    
    enum PadType: Int {
        case PadUnknown
        case Pad2
        case PadMini
        case Pad3
        case Pad4
        case PadAir
        case PadMini2
        case PadMini3
        case PadMini4
        case PadAir2
        case PadPro9Inch
        case PadPro12Inch
        case Pad5
        case PadPro12Inch2
        case PadPro10Inch
        case Pad6
        //2019年3月发布，更新二种机型：iPad mini5、iPad Air3
        case PadMini5
        case PadAir3
    }
    
}
