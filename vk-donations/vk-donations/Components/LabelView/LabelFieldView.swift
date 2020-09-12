//
//  LabelFieldView.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class LabelFieldView: NibView, Wizardable {
    
    var model: DonationWizardModel!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: MainTextView! {
        didSet {
            self.textView.textView.isEditable = false
            self.textView.textView.isUserInteractionEnabled = false
        }
    }
    
    func setupUI(model: DonationWizardModel) {
        self.model = model
        self.titleLabel.text = model.title
        self.textView.textView.text = model.value
        self.textView.textView.textColor = .black
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
