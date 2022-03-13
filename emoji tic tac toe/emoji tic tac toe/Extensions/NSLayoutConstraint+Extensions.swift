//
//  NSLayoutConstraint+Extensions.swift
//  19390245_cse2max_assessment2
//
//  Created by Justin Patterson on 3/9/21.
//

import UIKit

extension NSLayoutConstraint {
    
    /// Returns the constraint sender with the passed priority.
    ///
    /// - Parameter priority: The priority to be set.
    /// - Returns: The sended constraint adjusted with the new priority.
    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}
