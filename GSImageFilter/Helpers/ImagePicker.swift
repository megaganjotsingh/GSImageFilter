//
//  ImagePicker.swift
//  GSImageFilter
//
//  Created by Gaganjot Singh on 10/09/23.
//

import Foundation
import MobileCoreServices
import Photos
import UIKit

typealias ImageControllerProtocol = UIImagePickerControllerDelegate & UINavigationControllerDelegate

class ImagePickerController {
    static var shared = ImagePickerController()
    private let mediaPickerController = UIImagePickerController()
    private weak var viewController: ImageControllerProtocol?
    private var mediaType: [String] = [UTType.image.identifier as String]

    private init() {}

    func didTapCameraButton(_ vc: ImageControllerProtocol, title: String? = nil) {
        viewController = vc
        let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.checkCamera { _ in
                DispatchQueue.main.async {
                    self.openCamera(with: self.mediaType)
                }
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in

            DispatchQueue.main.async {
                self.openGallery(with: self.mediaType)
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        sharedSceneDelegate.window?.rootViewController?.present(actionSheet, animated: true, completion: nil)
    }
}

// MARK: Private functions

// MARK:

extension ImagePickerController {
    private func openCamera(with mediaType: [String], animated: Bool = true) {
        // Opens the camera after user permission is granted

        let sourceType = UIImagePickerController.SourceType.camera

        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            mediaPickerController.sourceType = sourceType
            mediaPickerController.mediaTypes = mediaType
            mediaPickerController.allowsEditing = true
            mediaPickerController.modalPresentationStyle = .fullScreen

            if mediaPickerController.sourceType == UIImagePickerController.SourceType.camera {
                mediaPickerController.showsCameraControls = true
            }

            checkCamera(cameraStatus: { [weak self] success in
                guard let `self` = self else { return }
                if success {
                    self.openPicker(self.mediaPickerController, animated: animated)
                }
            })
        }
    }

    private func openGallery(with mediaType: [String]) {
        // Opens the gallery after user permission is granted

        mediaPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        mediaPickerController.mediaTypes = mediaType
        mediaPickerController.allowsEditing = true
        mediaPickerController.modalPresentationStyle = .fullScreen

        checkGallery { success in
            if success {
                DispatchQueue.main.async {
                    self.openPicker(self.mediaPickerController)
                }
            }
        }
    }

    private func openPicker(_ mediaPickerController: UIImagePickerController, animated: Bool = true) {
        mediaPickerController.delegate = viewController
        sharedSceneDelegate.window?.rootViewController?.present(mediaPickerController, animated: animated, completion: nil)
    }
}

// MARK: Check camera and gallery Permission

extension ImagePickerController {
    func checkCamera(cameraStatus: @escaping (_ success: Bool) -> Void) {
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)

        switch cameraAuthorizationStatus {
        // The client is authorized to access the hardware supporting a media type.
        case .authorized:
            DispatchQueue.main.async {
                cameraStatus(true)
            }
        case .restricted:
            break
        // The user explicitly denied access to the hardware supporting a media type for the client.
        case .denied:
            let alertController = UIAlertController(title: "", message: "Camera permission is required to proceed. Do you want to provide it now?", preferredStyle: .alert)

            let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                if let url = settingsUrl {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)

            DispatchQueue.main.async {
                sharedSceneDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                cameraStatus(false)
            }

        case .notDetermined:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                DispatchQueue.main.async {
                    cameraStatus(granted)
                }
            }
        @unknown default:
            return
        }
    }

    private func checkGallery(galleryStatus: @escaping (_ success: Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            switch status {
            case PHAuthorizationStatus.authorized:
                galleryStatus(true)
            case PHAuthorizationStatus.denied:
                let alertController = UIAlertController(title: "", message: "Gallery permission is required to proceed. Do you want to provide it now?", preferredStyle: .alert)

                let settingsAction = UIAlertAction(title: "Settings", style: .default) { _ in
                    let settingsUrl = URL(string: UIApplication.openSettingsURLString)
                    if let url = settingsUrl {
                        DispatchQueue.main.async {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }

                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)

                alertController.addAction(cancelAction)
                alertController.addAction(settingsAction)
                DispatchQueue.main.async {
                    sharedSceneDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                    galleryStatus(false)
                }

            default:
                break
            }
        }
    }
}
