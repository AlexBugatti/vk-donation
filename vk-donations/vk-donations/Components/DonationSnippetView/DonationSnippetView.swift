//
//  DonationSnippetView.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationSnippetView: NibView {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 10
            self.containerView.layer.masksToBounds = true
            self.containerView.layer.borderColor = #colorLiteral(red: 0.9182453156, green: 0.9182668328, blue: 0.9182552695, alpha: 1).cgColor
            self.containerView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
