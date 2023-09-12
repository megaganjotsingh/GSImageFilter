//
//  NSObject+Extension.swift
//  GSImageFilter
//
//  Created by Admin on 11/09/23.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }

    static var className: String {
        return String(describing: "\(self)")
    }
}
