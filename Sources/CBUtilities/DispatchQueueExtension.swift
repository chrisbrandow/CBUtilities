//
//  DispatchQueueExtension.swift
//  
//
//  Created by Chris Brandow on 1/28/23.
//

import Foundation

extension DispatchQueue {

    public func cb_perform(after  delay: TimeInterval, block: @escaping (() -> Void)) {
        let dispatchTime = DispatchTime.now() + delay
        self.asyncAfter(deadline: dispatchTime, execute: block)
    }

}
