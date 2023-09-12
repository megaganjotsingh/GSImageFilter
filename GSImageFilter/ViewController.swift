//
//  ViewController.swift
//  GSImageFilter
//
//  Created by Gaganjot Singh on 09/09/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var toolBarView: UIView!
    @IBOutlet var heightToolView: NSLayoutConstraint!

    private var originalImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFilterView()
    }

    @IBAction func pickImage(_: UIButton) {
        ImagePickerController.shared.didTapCameraButton(self)
    }

    @IBAction func showFilters(_: UIButton) {
        showToolView(height: 164)
    }

    func setupFilterView() {
        let view = createFilterToolView(baseToolView: toolBarView) as! FilterToolView
        view.closeToolViewClick = { [unowned self] in
            self.hideToolView()
        }
        view.okToolViewClick = { [weak self] in
            let index = view.index
            if index != -1, let oImage = self?.originalImage {
                ImageFilterManager.shared.addFilter(name: CIFilterNames[index], onImage: oImage) { [weak self] processedImage in
                    self?.imageView.image = processedImage
                }
            }
            self?.hideToolView()
        }

        toolBarView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: toolBarView.topAnchor),
            view.bottomAnchor.constraint(equalTo: toolBarView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: toolBarView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: toolBarView.trailingAnchor),
        ])
    }

    func createFilterToolView(baseToolView _: UIView) -> BaseToolView {
        let width = UIScreen.main.bounds.size.width
        let filterToolView = FilterToolView.fromNib(name: FilterToolView.className) as? BaseToolView
        (filterToolView as? FilterToolView)?.setupCollection()
        filterToolView!.frame = CGRect(x: 0, y: 0, width: width, height: 164)
        return filterToolView!
    }

    func showToolView(height: Float) {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.heightToolView.constant = CGFloat(height)
            self.view.layoutIfNeeded()
        }
    }

    func hideToolView() {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.heightToolView.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}

extension ViewController: ImageControllerProtocol {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            imageView.image = image
            originalImage = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
