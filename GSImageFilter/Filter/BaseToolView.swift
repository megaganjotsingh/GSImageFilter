//
//  BaseToolView.swift
//  GSImageFilter
//
//  Created by Gaganjot Singh on 10/09/23.
//

import Foundation
import UIKit

enum ToolKitType: Int {
    case AddSticker = 0
}

class BaseToolView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var closeToolViewClick: (() -> Void)?
    var okToolViewClick: (() -> Void)?
}
