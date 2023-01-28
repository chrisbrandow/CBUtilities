//
//  DispatchQueueExtension.swift
//  
//
//  Created by Chris Brandow on 1/28/23.
//

import Foundation

extension DispatchQueue {

    public func cb_perform(block: @escaping (() -> Void), withDelay delay: TimeInterval) {
        let dispatchTime = DispatchTime.now() + delay
        self.asyncAfter(deadline: dispatchTime, execute: block)
    }
    
}
