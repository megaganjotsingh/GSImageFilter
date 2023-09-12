//
//  Constants.swift
//  GSImageFilter
//
//  Created by Admin on 11/09/23.
//

import UIKit.UIApplication

let filters = [
    "Luminance",
    "Chrome",
    "Fade",
    "Instant",
    "Noir",
    "Process",
    "Tonal",
    "Transfer",
    "Sepia Tone",
    "Color Clamp",
    "ColorInvert",
    "Color Monochrome",
    "Spot Light",
    "Color Posterize",
    "Box Blur",
    "Disc Blur",
    "Gaussian Blur",
    "Masked Variable Blur",
    "Median Filter",
    "Motion Blur",
    "Noise Reduction",
]

let CIFilterNames = [
    "CISharpenLuminance",
    "CIPhotoEffectChrome",
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectNoir",
    "CIPhotoEffectProcess",
    "CIPhotoEffectTonal",
    "CIPhotoEffectTransfer",
    "CISepiaTone",
    "CIColorClamp",
    "CIColorInvert",
    "CIColorMonochrome",
    "CISpotLight",
    "CIColorPosterize",
    "CIBoxBlur",
    "CIDiscBlur",
    "CIGaussianBlur",
    "CIMaskedVariableBlur",
    "CIMedianFilter",
    "CIMotionBlur",
    "CINoiseReduction",
]

let sharedSceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
