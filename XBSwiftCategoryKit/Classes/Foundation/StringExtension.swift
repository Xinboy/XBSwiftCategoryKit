//
//  StringExtension.swift
//  XBSwiftCategoryKit
//
//  Created by Xinbo Hong on 2019/7/3.
//

import Foundation
import CommonCrypto
// MARK: - 加解密,如项目导入CryptoSwift只需直接使用第三方方法
extension String {
    
    // MARK: - MD5
    func md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        free(result)
        return String(format: hash as String)
    
    }
    
    // MARK: - BASE64
    var base64: String {
        let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue)
        let base64String = plainData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String
    }

    static func encryptBASE64(inPutText: String) -> String {
        let encodeData = inPutText.data(using: .utf8)
        return (encodeData?.base64EncodedString())!
    }
    
    func encryptBASE64() -> String {
        return String.encryptBASE64(inPutText: self)
        
    }
    
    static func decryptBASE64(inPutText: String) -> String {
        let decodeData = Data.init(base64Encoded: inPutText)
        return String.init(data: decodeData!, encoding: .utf8)!
    }
    
    func decryptBASE64(key: String) -> String {
        return String.decryptBASE64(inPutText: self)
    }
    
}

// MARK: - 正则表达式
extension String {
    struct Validation {
        static let userName = "^[\\u4E00-\\u9FA5A-Za-z0-9]-$"
        static let password = "^[a-zA-Z][a-zA-Z0-9_]{5,15}$"
        static let email = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        static let carNumber = "^[\\u4e00-\\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4,5}[a-zA-Z_0-9_\\u4e00-\\u9fff]$"
        static let phoneNumber = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|198|199|(147))\\d{8}$"
        static let idCard = "^(\\d{14}|\\d{17})(\\d|[xX])$"
        static let ipv4Address = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
        static let macAddress = "([A-Fa-f\\d]{2}:){5}[A-Fa-f\\d]{2}"
        static let url = "^((http)|(https))+:[^\\s]+\\.[^\\s]*"
        static let chinese = "^[\\u4e00-\\u9fa5]+$"
        static let postalCode = "^[\\u4e00-\\u9fa5]+$"
        static let taxNo = "[0-9]\\d{13}([0-9]|X)$"
        
    }
    
    
    /// 正则匹配字符：中文、英文、数字但不包括下划线等符号
    func isUserName() -> Bool {
        return self.basePredicate(regex: Validation.userName)
    }
    
    /// 正则匹配密码：英文、数字和下划线；长度6 - 16位
    func isPassword() -> Bool {
        return self.basePredicate(regex: Validation.password)
    }

    /// 正则匹配邮箱
    func isEmail() -> Bool {
        return self.basePredicate(regex: Validation.email)
    }

    /// 正则匹配车牌号：车牌号:湘K-DE829 香港车牌号码:粤Z-J499港
    func isCarNumber() -> Bool {
        return self.basePredicate(regex: Validation.carNumber)
    }

    /// 正则匹配手机号码：11位和所有运营商
    func isPhoneNumber() -> Bool {
        return self.basePredicate(regex: Validation.phoneNumber)
    }
    
    /// 正则匹配身份证号：身份证号
    func isIDCard() -> Bool {
        return self.basePredicate(regex: Validation.idCard)
    }
    
    ///  正则精确匹配身份证号：身份证号
    func isExactIDCard() -> Bool {
        
        if self.count != 18 {
            return false
        }
        
        let regex = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$"
        let flag = self.basePredicate(regex: regex)
        
        if !flag {
            //格式错误
            return flag
        } else {
            //将前 17 位加权因子保存在数组里
            let idCardWiArray = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"]
            //这是除以 11 后，可能产生的 11 位余数、验证码，也保存成数组
            let idCardYArray = ["1", "0", "10", "9", "8", "7", "6", "5", "4", "3", "2"]
            
            //用来保存前 17 位各自乖以加权因子后的总和
            var idCardWiSum = 0
            
            for i in 0..<17 {
                let subInt = Int(self.subString(i, length: 1))!
                let wiInt = Int(idCardWiArray[i])!
                
                idCardWiSum = idCardWiSum + subInt * wiInt
            }
            
            //计算出校验码所在数组的位置
            let idCardMod = idCardWiSum % 11
            
            //得到最后一位身份证号码
            let idCardLast = self.subString(17, length: 1)
            //如果等于 2，则说明校验码是 10，身份证号码最后一位应该是X
            if idCardMod == 2 {
                if idCardLast == "x" || idCardLast == "X" {
                    return true
                } else {
                    return false
                }
            } else {
                 //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
                if idCardLast == idCardYArray[idCardMod] {
                    return true
                } else {
                    return false
                }
            }
        }
    }

    /**
     *  正则匹配银行卡的有效性
     *  银行卡号有效性问题 Luhn 算法
     *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
     *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
     *  16 位卡号校验位采用 Luhm 校验方法计算：
     *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
     *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
     *  3，将加法和加上校验位能被 10 整除。
     */
    func isBankCardID() -> Bool {
        
        let lastNumString = self.substring(from: self.count - 1)
        let forwardNumString = self.substring(to: self.count - 1)
        
        var forwardArray = Array<String>()
        for i in 0..<forwardNumString.count {
            let subStr = forwardNumString.substring(with: NSRange.init(location: i, length: i))
            forwardArray.append(subStr)
        }
        
        var forwardDescArray = Array<String>()
        for i in forwardDescArray.reversed().enumerated() {
            forwardDescArray.append(i.element)
        }
    
        var oddNumberArray = Array<Int>()
        var oddNumberArray2 = Array<Int>()
        var evenNumberArray = Array<Int>()
        
        for i in 0..<forwardDescArray.count {
            let num = Int(forwardDescArray[i])!
            
            if i % 2 == 0 {
                evenNumberArray.append(num)
            } else {
                if num * 2 < 9 {
                    oddNumberArray.append(num * 2)
                } else {
                    let decadeNum: Int = (num * 2) / 10
                    let unitNum: Int = (num * 2) % 10
                    
                    oddNumberArray2.append(unitNum)
                    oddNumberArray2.append(decadeNum)
                }
            }
        }
        var sumOddTotal = 0
        for (_, value) in evenNumberArray.enumerated() {
            sumOddTotal += value
        }
        
        var sumOddTotal2 = 0
        for(_, value) in oddNumberArray2.enumerated() {
            sumOddTotal2 += value
        }
        
        var sumEvenTotal = 0
        for(_, value) in evenNumberArray.enumerated() {
            sumEvenTotal += value
        }
        
        let lastNum = lastNumString.toNumber().intValue
        
        let luhmTotal = lastNum + sumEvenTotal + sumOddTotal + sumOddTotal2
        
        return (luhmTotal % 10 == 0) ? true : false
        
    }
    

    /// 正则匹配Ipv4地址有效性
    func isIpv4Address() -> Bool {
        let rc = self.basePredicate(regex: Validation.ipv4Address)
        if rc {
            let componds = self.components(separatedBy: ",")
            var v = true
            for s in componds {
                if s.toNumber().intValue > 255 {
                    v = false
                    break
                }
            }
            return v
        }
        return false
    }

    
    /// 正则匹配Mac地址有效性
    func isMacAddress() -> Bool {
        return self.basePredicate(regex: Validation.macAddress)
    }
    
    /// 正则匹配网址有效性
    func isUrl() -> Bool {
        return self.basePredicate(regex: Validation.url)
    }
    

     /// 正则匹配纯汉字
     func isChinese() -> Bool {
        return self.basePredicate(regex: Validation.chinese)
    }

    
    /// 正则匹配邮政编码
    func isPostalcode() -> Bool {
        return self.basePredicate(regex: Validation.postalCode)
    }
    
    /// 正则匹配工商税号
    func isTaxNo() -> Bool {
        return self.basePredicate(regex: Validation.taxNo)
    }
    
    /// 根据输入的正则表达式判断字符串是否正确
    func isRigth(with regex: String) -> Bool {
        return self.basePredicate(regex: regex)
    }
    
    
    private func basePredicate(regex: String) -> Bool {
        var result = ""
        
        let regexExp = try! NSRegularExpression.init(pattern: regex, options: .caseInsensitive)
        let res = regexExp.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
        
        for checkingRes in res {
            result = result + (self as NSString).substring(with: checkingRes.range)
        }
        if result == self{
            return true
        }else{
            return false
        }
    }
    
    
}

// MARK: - 常用方法
extension String {
    
    // MARK: - 子字符串相关
    /// 查找父字符串中子字符串的range
    func range(subString: String) -> NSRange {
        let range = self.range(of: subString)
        guard let from = range?.lowerBound.samePosition(in: self.utf16),
            let to = range?.upperBound.samePosition(in: self.utf16) else {
                return NSRange.init(location: 0, length: 0)
        }
        
        return NSRange.init(location: self.utf16.distance(from: self.utf16.startIndex, to: from), length: self.utf16.distance(from: from, to: to))
    }
    
    
    /// 根据给的开始位置和长度，获取子字符串
    func subString(_ from: Int, length: Int) -> String {
        if from >= self.count || from < 0 || length == 0 {
            return ""
        }
        let began = self.index(self.startIndex, offsetBy: from)
        let end = self.index(began, offsetBy: length)
        let subString = String(self[began..<end])
        
        return subString
    }
    
    /// 根据开始位置，获取子字符串
    func substring(from index: Int) -> String {
        return String(self[..<self.index(self.startIndex, offsetBy: index)])
    }
    
    
    /// 根据结束位置，获取子字符串
    func substring(to index: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: index)...])
    }
    
    
    /// 根据范围，获取子字符串
    func substring(with range: NSRange) -> String {
        return self.subString(range.location, length: range.length)
    }
    
//    /// 根据字符串查找有无子字符串
//    func substring(with sub: String) -> NSRange? {
//        return self.subString(range.location, length: range.length)
//    }

    
    
    /// NSRange转换为Range
    func toRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    /// Range转换为NSRange
    func toNSRange(from range: Range<String.Index>) -> NSRange {
        //Swift4 新增方法
        return NSRange(range, in: self)
        
    }
    
    
    // MARK: - 字符串转换/格式化相关
    
    /// 将null字符串转换为“”字符串
    static func nilString(_ str: String?) -> String {
        if str == nil || str == "(null)" || str == "null" {
            return ""
        }
        return str!
    }
    
    
    /// 将 null 字符串转换为“”字符串
    mutating func nilString() {
        if self == "(null)" || self == "null" {
            self = ""
        }
    }
    
    /// String 转 NSString
    var toNSString: NSString { return self as NSString }
    
    /// 是否包含 Emoji 表情
    func includesEmoji() -> Bool {
        for i in 0...self.count {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
    
    /// 判断是否是数值字符串，包含小数点
    func isNumber() -> Bool {
        let scan: Scanner = Scanner.init(string: self)
        var val: Float = 0
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /// 字符串转整型
    func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// 字符串转双精度浮点类型
    func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// 字符串转浮点类型
    func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    /// 字符串转布尔类型
    func toBool() -> Bool? {
        let trimmedString = self.removedSpaces().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    /// 字符串转NSNumbere类型
    func toNumber() -> NSNumber {
        if !self.isNumber() {
            return NSNumber.init(value: 0.0)
        } else {
            return NSNumber.init(value: Float(self)!)
        }
    }
    
    /// NSNumber 转字符串
    static func toString(from number: NSNumber?) -> String {
        if number != nil {
            return (number?.stringValue)!
        } else {
            return ""
        }
    }
    
    /// 字符串转 Data
    func toData() -> Data {
        return self.data(using: .utf8)!
    }
    
    /// Data 转字符串
    static func toString(from data: Data?) -> String {
        if data != nil{
            return String.init(data: data!, encoding: .utf8)!
        } else {
            return ""
        }
        
    }
    
    /// 字符串转 Date，默认yyyy-MM-dd
    func toDate(format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    /// Data 转字符串，默认yyyy-MM-dd
    static func toString(from date: Date?, format: String = "yyyy-MM-dd") -> String {
        if date != nil{
            let formatter = DateFormatter.init()
            formatter.dateFormat = format
            return formatter.string(from: date!)
        } else {
            return ""
        }
    }
    
    
    /// 格式化：具有千分位且保留两位小数的字符串
    func positiveFloatFormat() -> String {
        if !self.isNumber() {
            return "0.00"
        }
        
        let numberFormatter = NumberFormatter.init()
        numberFormatter.positiveFormat = ",###.00;"
        return numberFormatter.string(from: self.toNumber())!
    }
    
    /// 格式化：具有千分位的整数字符串
    func positiveIntFormat() -> String {
        if !self.isNumber() {
            return "0.00"
        }
        
        let numberFormatter = NumberFormatter.init()
        numberFormatter.positiveFormat = ",###;"
        return numberFormatter.string(from: self.toNumber())!
    }
    
    
    // MARK: - 清除特定字符相关
    
    /// 清除 HTML 标签
    func removedHTML() -> String {
        let removeString = "<[^>]+>"
        
        return self.replacingOccurrences(of: removeString, with: "", options: .regularExpression, range:self.toRange(from: NSRange.init(location: 0, length: self.count)))
    }
    
    /// 清除空格和换行
    mutating func removeHTML() {
        self = self.removedHTML()
    }

    /// 清除空格
    func removedSpaces() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    /// 清除空格和换行
    mutating func removeSpaces() {
        self = self.removedSpaces()
    }
    
    /// 清除空格和换行
    func removedSpaceAndEnter() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    /// 清除空格和换行
    mutating func removeSpaceAndEnter() {
        self = self.removedSpaceAndEnter()
    }
    
}

