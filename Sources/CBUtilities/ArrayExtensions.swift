//
//  File.swift
//  
//
//  Created by Chris Brandow on 10/28/22.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

    func forEachAndNext(_ block: @escaping (Element, Element) -> Void) {
        guard count >= 2 else { return }
        var previous: Element?
        self.forEach { current in
            if let previous {
                block(previous, current)
            }
            previous = current
        }
    }
}
