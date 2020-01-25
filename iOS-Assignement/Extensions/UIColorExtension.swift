//
//  UIColorExtension.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-25.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import UIKit

extension UIColor {
    class func hexStringToUIColor(hex: String) -> UIColor {
        var color: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if color.hasPrefix("#") {
            color.remove(at: color.startIndex)
        }
        
        if color.count != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: color).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
