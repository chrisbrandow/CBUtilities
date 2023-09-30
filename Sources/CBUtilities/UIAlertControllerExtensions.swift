//
//  File.swift
//  
//
//  Created by Chris Brandow on 9/30/23.
//

import UIKit

public extension UIAlertController {

    /// the action handlers are called after this method dismisses the alert controller
    static func yesNoAlert(_ title: String, message: String, yes: @escaping ((UIAlertAction) -> Void), no: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { action in controller.dismiss(animated: true) { yes(action) } }
        let noAction = UIAlertAction(title: "No", style: .default) { action in controller.dismiss(animated: true) { no?(action) } }
        controller.addAction(noAction)
        controller.addAction(yesAction)
        return controller
    }

    static func equalChoiceAlert(_ title: String, message: String, first: String, second: String? = nil, firstBlock: @escaping ((UIAlertAction) -> Void), secondBlock: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: first, style: .default) { action in controller.dismiss(animated: true) { firstBlock(action) } }
        let noAction = UIAlertAction(title: second ?? "OK", style: .default) { action in controller.dismiss(animated: true) { secondBlock?(action) } }
        controller.addAction(noAction)
        controller.addAction(yesAction)
        return controller
    }
}

