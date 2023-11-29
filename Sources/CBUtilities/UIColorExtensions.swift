//
//  File.swift
//  
//
//  Created by Chris Brandow on 9/30/23.
//

import UIKit


public extension UIColor {

    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        guard hex.hasPrefix("#")
        else { return nil }
        let start = hex.index(hex.startIndex, offsetBy: 1)
        var hexColor = String(hex[start...]) + (hex.count < 8 ? "FF" : "")

        if hexColor.count == 8
        {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            guard scanner.scanHexInt64(&hexNumber)
            else { return nil }

            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255

            guard hexColor.count == 8 else {
                self.init(red: r, green: g, blue: b, alpha: 1.0)
                return
            }
            a = CGFloat(hexNumber & 0x000000ff) / 255
            self.init(red: r, green: g, blue: b, alpha: a)
        } else {
            return nil
        }

    }
}

