//
//  ImagePicker.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

open class ImagePicker: NSObject {

    var didSelect: ((UIImage?)->Void)?
    
    private var pickerController: UIImagePickerController!
    private weak var presentationController: UIViewController?

    public init(presentationController: UIViewController) {
//        self.pickerController = UIImagePickerController()

        super.init()

        self.presentationController = presentationController

//        self.pickerController.delegate = self
//        self.pickerController.allowsEditing = true
//        self.pickerController.mediaTypes = ["public.image"]
    }

    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.pickerController = UIImagePickerController()
            self.pickerController.sourceType = type
            self.pickerController.delegate = self
            self.pickerController.allowsEditing = true
            self.pickerController.mediaTypes = ["public.image"]
            self.presentationController?.present(self.pickerController, animated: true)
        }
        
       return action
//        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
//            self.pickerController = UIImagePickerController()
//            self.pickerController.sourceType = type
//            self.pickerController.delegate = self
//            self.pickerController.allowsEditing = true
//            self.pickerController.mediaTypes = ["public.image"]
//            self.presentationController?.present(self.pickerController, animated: true)
//        }
    }

    public func present(from sourceView: UIView) {

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        if let action = self.action(for: .camera, title: "Сделать фото") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Камера") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Галерея") {
            alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        if UIDevice.current.userInterfaceIdiom == .pad {
            alertController.popoverPresentationController?.sourceView = sourceView
            alertController.popoverPresentationController?.sourceRect = sourceView.bounds
            alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
        }

        self.presentationController?.present(alertController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)

        self.didSelect?(image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate {

}
