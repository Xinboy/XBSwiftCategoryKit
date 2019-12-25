//
//  UIColorExtensions.swift
//  XBSwiftCategoryKit
//
//  Created by Xinbo Hong on 2019/7/24.
//

import Foundation

extension UIColor {
    /// 获取颜色，RGB范围：[0,255],透明度：[0,1]
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    /// 十六进制整型生成颜色
    convenience init?(hexInt: Int, alpha: CGFloat = 1) {
        if hexInt > 0xFFFFFF {
            let red = CGFloat(CGFloat((hexInt & 0xFF0000) >> 16) / 255.0)
            let green = CGFloat(CGFloat((hexInt & 0x00FF00) >> 8) / 255.0)
            let blue = CGFloat(CGFloat((hexInt & 0x0000FF) >> 0) / 255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
    

    /// 十六进制字符串生成颜色
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            self.init(hexInt: hex, alpha: alpha)
        } else {
            return nil
        }
    }

    /// 灰度色
    convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }
    
    /// 改变颜色透明度
    func change(alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
        
    }
    
    /// 获取随机颜色
    static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor.init(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
    
    /// 获取红色值
    var redComponent: Int {
        var r: CGFloat = 0
        self.getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    /// 获取绿色值
    var greenComponent: Int {
        var g: CGFloat = 0
        self.getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    /// 获取蓝色值
    var blueComponent: Int {
        var b: CGFloat = 0
        self.getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    /// 获取透明度值
    var alpha: CGFloat {
        var a: CGFloat = 0
        self.getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    
    /// 获取颜色的数据：[red, green, blue, alpha]
    var rgbArray: Array<CGFloat> {
        return [CGFloat(self.redComponent),
                CGFloat(self.greenComponent),
                CGFloat(self.blueComponent),
                self.alpha]
    }
    
    
    /// 获取颜色的十六进制数据：#RRGGBB
    var hexString: String {
        let r = String.init(format: "%02x", self.redComponent)
        let g = String.init(format: "%02x", self.greenComponent)
        let b = String.init(format: "%02x", self.blueComponent)
        
        return String.init(format: "#%@%@%@", r, g, b)
    }
    
    /// 渐变色。 未完成
    static func gradient(fromColor: UIColor, toColor: UIColor, height: CGFloat) {
        guard let currentContext = UIGraphicsGetCurrentContext() else { return }
        
        currentContext.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard let fromColorComponent = fromColor.cgColor.components else { return }
        guard let toColorComponent = toColor.cgColor.components else { return }
        
        let colorComponents: [CGFloat]
            = [fromColorComponent[0],
               fromColorComponent[1],
               fromColorComponent[2],
               fromColorComponent[3],
               toColorComponent[0],
               toColorComponent[1],
               toColorComponent[2],
               toColorComponent[3]]
        
        // 6
        
        let location: [CGFloat] = [0.0, 1.0]
        
        guard let gradient = CGGradient(colorSpace: colorSpace,
                                        colorComponents: colorComponents,
                                        locations: location,
                                        count: 2) else { return }
        
        
        let fromPoint = CGPoint.init(x: 0, y: 0)
        let toPoint = CGPoint.init(x: 0, y: height)
        
        currentContext.drawLinearGradient(gradient, start: fromPoint, end: toPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        currentContext.restoreGState()
        
        return UIImage.init()
    }
}
