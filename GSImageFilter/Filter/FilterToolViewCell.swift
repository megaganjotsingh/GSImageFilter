//
//  FilterToolViewCell.swift
//  GSImageFilter
//
//  Created by Gaganjot Singh on 10/09/23.
//

import UIKit

class FilterToolViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .white
    }
}
