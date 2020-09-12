//
//  Wizardable.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

protocol Wizardable {
    func setupUI(model: DonationWizardModel)
    func getValue() -> String?
    
    var model: DonationWizardModel! { get set}
}
