//
//  DonationTypeView.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationTypeView: NibView {

    var didActionTapped: (()->Void)?
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = 10
            self.containerView.layer.masksToBounds = true
            self.containerView.layer.borderColor = #colorLiteral(red: 0.8829681277, green: 0.8829888701, blue: 0.8829776645, alpha: 1)
            self.containerView.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupUI(typeNodel: DonationTypeModel) {
        self.iconView.image = typeNodel.icon
        self.titleLabel.text = typeNodel.title
        self.descriptionLabel.text = typeNodel.descriptionString
    }
    
    @IBAction func onDidActionTapped(_ sender: Any) {
        self.didActionTapped?()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
