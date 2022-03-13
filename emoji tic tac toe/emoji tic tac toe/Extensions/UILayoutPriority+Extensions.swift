//
//  UILayoutPriority+Extensions.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 3/9/21.
//

import UIKit

extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
}
