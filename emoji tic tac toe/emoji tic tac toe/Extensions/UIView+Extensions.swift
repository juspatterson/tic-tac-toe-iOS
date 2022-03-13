//
//  UIView+Extensions.swift
//  emoji tic tac tow
//
//  Created by Justin Patterson on 11/9/21.
//

import UIKit

extension UIView {
    var dockView: [UIView] {
        "\(type(of: self))".contains("DockView")
        ? [self]
        : subviews.flatMap(\.dockView)
    }
    
    var firstResponder: [UIView] {
        isFirstResponder
        ? [self]
        : subviews.flatMap(\.firstResponder)
    }
}
