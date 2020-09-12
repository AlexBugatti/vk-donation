//
//  TextFieldView.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class TextFieldView: NibView, Wizardable {

    var model: DonationWizardModel!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: MainTextView!
    
    func setupUI(model: DonationWizardModel) {
        self.model = model
        self.titleLabel.text = model.title
        self.textView.placeholderText = model.subtitle
        
        if let keyboardType = model.keyboardType {
            self.textView.textView.keyboardType = keyboardType
        }
    }
    
    func getValue() -> String? {
        return self.textView.textView.text
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
