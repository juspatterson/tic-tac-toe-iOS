//
//  UIApplication+Extensions.swift
//  emoji tic tac tow
//
//  Created by Justin Patterson on 11/9/21.
//

import UIKit

extension UIApplication {
    var keyboardWindow: UIWindow? {
        windows.first { "\(type(of: $0))".contains("Keyboard") }
    }
}
