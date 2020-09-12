//
//  DonationWizardController.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationWizardController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var type: DonationTypeModel!
    var pickerController: UIImagePickerController!
    var fields: [DonationWizardModel] = []
    
    private var observers = [NSObjectProtocol]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
        self.navigationItem.title = self.type.type == .target ? "Целевой сбор" : "Регулярный сбор"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterKeyboardNotifications()
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        let objects = DonationWizardModel.regular()
        
        objects.forEach { (obj) in
            let fieldView = obj.getView()
            fieldView.setupUI(model: obj)
            (fieldView as? InputImageView)?.didActionTapped = {
                DispatchQueue.main.async {
                    self.presentPicker(from: fieldView)
                }
            }
            fieldView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(fieldView)
        }
    }
    
    func addPhoto(image: UIImage) {
        
        if let inputImageView = self.stackView.arrangedSubviews.first(where: { $0.isKind(of: InputImageView.self) }) as? InputImageView, let model = inputImageView.model {
            
            model.image = image
            inputImageView.setupUI(model: model)
        }
        
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }

        let action = UIAlertAction(title: title, style: .default) { (action) in
            self.showImagePicker(type: type)
        }
        
       return action
    }
    
    func showImagePicker(type: UIImagePickerController.SourceType) {
        self.pickerController = UIImagePickerController()
        self.pickerController.sourceType = type
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
        self.present(self.pickerController, animated: true)
    }

    public func presentPicker(from sourceView: UIView) {

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

        self.present(alertController, animated: true)
    }
    
    func saveFields() -> Donation? {
        
        var title: String?
        var target: String?
        var description: String?
        var price: String?
        var image: UIImage?
        var author: String?
        
        self.stackView.arrangedSubviews.forEach { (subview) in
            
            if let wizardableModel = subview as? Wizardable {
                
                switch wizardableModel.model.identifier {
                case "title": title = wizardableModel.getValue()
                case "target": target = wizardableModel.getValue()
                case "description": description = wizardableModel.getValue()
                case "price": description = wizardableModel.getValue()
                case "image": image = (subview as? InputImageView)?.imageView.image
                    
                default:
                    break
                }
                
            }
            
        }
        
        if let titleString = title, let targetString = target, let descriptionString = description, let image = image, let author = author, let price = price {
            let donation = Donation.init(title: titleString, target: targetString, author: author, image: image, price: price)
            
            return donation
        }
        
        return nil
    }
    
    @IBAction func onDidNextTapped(_ sender: Any) {
        
        if let donation = self.saveFields() {
           self.performSegue(withIdentifier: "toPrepare", sender: donation)
        } else {
            let alert = UIAlertController.init(title: "Ошибка", message: "Не все поля заполнены", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPrepare", let vc = segue.destination as? DonationPreparePostController {
            vc.donation = sender as? Donation
        }
    }


}

extension DonationWizardController {
    
    // MARK: - Keyboard Observations
    
    func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        
        let willShowObserver = center.addObserver(with: UIViewController.keyboardWillShow) { payload in
            self.bottomConstraint.constant = -payload.endFrame.height
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { (success) in
                self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x,
                                                        y: self.scrollView.contentOffset.y + 20)
            }
        }
        
        let willHideObserver = center.addObserver(with: UIViewController.keyboardWillHide) { payload in
            self.bottomConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: { self.view.layoutIfNeeded() })
        }
        
        observers = [willShowObserver, willHideObserver]
    }
    
    func unregisterKeyboardNotifications() {
        observers.forEach({ NotificationCenter.default.removeObserver($0) })
    }
}

extension DonationWizardController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.addPhoto(image: chosenImage)
        
        dismiss(animated:true, completion: nil)
    }

    
}

extension DonationWizardController: UINavigationControllerDelegate {

}

