//
//  FilterToolView.swift
//  GSImageFilter
//
//  Created by Gaganjot Singh on 10/09/23.
//

import UIKit

class FilterToolView: BaseToolView {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var titleLabel: UILabel!

    var index = -1

    func setupCollection() {
        collectionView.register(UINib(nibName: FilterToolViewCell.className, bundle: nil), forCellWithReuseIdentifier: FilterToolViewCell.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        reloadData()
    }

    func reloadData() {
        collectionView.reloadData()
    }

    // - Action
    @IBAction func closeAction(_: Any) {
        closeToolViewClick?()
    }

    @IBAction func okAction(_: Any) {
        okToolViewClick?()
    }
}

extension FilterToolView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        titleLabel.text = filters[index]
        collectionView.reloadData()
    }
}

extension FilterToolView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
}

extension FilterToolView: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterToolViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterToolViewCell.className, for: indexPath) as! FilterToolViewCell
        if index == indexPath.row {
            cell.imageView.layer.borderColor = UIColor.blue.cgColor
            cell.imageView.layer.borderWidth = 2
        } else {
            cell.imageView.layer.borderColor = UIColor.clear.cgColor
            cell.imageView.layer.borderWidth = 0
        }
        cell.titleLabel.text = ""
        cell.imageView.image = UIImage(named: filters[indexPath.row].replacingOccurrences(of: " ", with: ""))
        return cell
    }
}
