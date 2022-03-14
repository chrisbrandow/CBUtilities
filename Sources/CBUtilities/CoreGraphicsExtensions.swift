//
//  File.swift
//  
//
//  Created by Christopher Brandow on 6/2/21.
//

import UIKit

public extension UIBezierPath {
    func move(toX x: CGFloat, y: CGFloat) {
        self.move(to: CGPoint(x: x, y: y))
    }

    func addLine(toX x: CGFloat, y: CGFloat) {
        self.addLine(to: CGPoint(x: x, y: y))
    }
}
