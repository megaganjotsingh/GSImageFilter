//
//  UIView+Extension.swift
//  GSImageFilter
//
//  Created by Admin on 12/09/23.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib(name: String) -> UIView {
        Bundle.main.loadNibNamed(name, owner: nil)?.first as! UIView
    }
}
