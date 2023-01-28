//
//  StringExtensions.swift
//  CBUtilities
//
//  Created by Chris Brandow on 1/28/23.
//

import Foundation

extension String {
    public func cb_string<T: LosslessStringConvertible & Equatable>(substituting substitutions: [T?]) -> String {
        let compactSubstitutions = substitutions.compactMap { $0 }
        guard substitutions.count == compactSubstitutions.count else {
            assertionFailure("substitions contained a nil value")
            return self }
        return compactSubstitutions.enumerated().reduce(self) { (parent: String, indexedSubstitution) -> String in
            let (index, item) = indexedSubstitution
            return parent.replacingOccurrences(of: "{\(index)}", with: String(describing: item))
        }
    }
}
