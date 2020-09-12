//
//  InputImageView.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class InputImageView: NibView, Wizardable {
    
    var didActionTapped: (()->Void)?
    
    var model: DonationWizardModel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.layer.cornerRadius = 10
            self.imageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.containerView.addDashedBorder()
    }
    
    func setupUI(model: DonationWizardModel) {
        self.model = model
        if let image = model.image {
            self.dismissButton.isHidden = false
            self.imageView.image = image
        } else {
            self.dismissButton.isHidden = true
        }
    }
    
    func getValue() -> String? {
        return nil
    }
    
    @IBAction func onDidActionTapped(_ sender: Any) {
        self.didActionTapped?()
    }
    
    @IBAction func onDimissTapped(_ sender: Any) {
        self.imageView.image = nil
        self.model?.image = nil
        self.dismissButton.isHidden = true
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
