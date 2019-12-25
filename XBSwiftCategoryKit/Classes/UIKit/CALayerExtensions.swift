//
//  CALayerExtensions.swift
//  Pods-XBSwiftCategoryKit_Example
//
//  Created by Xinbo Hong on 2019/12/24.
//

import UIKit

extension CALayer  {
    func setShadow(color: UIColor? = .black,
                   alpha: CGFloat = 0.5,
                   x: CGFloat = 0, y: CGFloat = 2,
                   blur: CGFloat = 4,
                   spread: CGFloat = 0) {
        self.shadowOffset = CGSize(width: x, height: y)
        self.shadowRadius = blur * 0.5
        self.shadowColor = color?.cgColor
        self.shadowOpacity = Float(alpha)

        let rect = self.bounds.insetBy(dx: -spread, dy: -spread)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: self.cornerRadius)
        self.shadowPath = path.cgPath
    }

}
