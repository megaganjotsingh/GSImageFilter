//
//  ImageFilterManager.swift
//  GSImageFilter
//
//  Created by Admin on 10/09/23.
//

import CoreImage
import Foundation
import UIKit

class ImageFilterManager {
    static var shared = ImageFilterManager()

    private init() {}

    func addFilter(name: String, onImage image: UIImage, completion: @escaping (UIImage) -> Void) {
        let context = CIContext()

        if let currentFilter = CIFilter(name: name) {
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

            if let output = currentFilter.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    // do something interesting with the processed image
                    completion(processedImage)
                }
            }
        }
    }
}
