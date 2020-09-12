//
//  DonationTypeModel.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

struct DonationTypeModel {

    enum `Type` {
        case target
        case regular
    }
    
    var icon: UIImage
    var title: String
    var descriptionString: String
    var type: Type
    
    static var target: DonationTypeModel {
        return DonationTypeModel(icon: #imageLiteral(resourceName: "target"),
                                 title: "Целевой сбор",
                                 descriptionString: "Когда есть определенная цель",
                                 type: .target)
    }
    static var regular: DonationTypeModel {
        return DonationTypeModel(icon: #imageLiteral(resourceName: "calendar"),
                                 title: "Регулярный сбор",
                                 descriptionString: "Если помощь нужна ежемесячно",
                                 type: .regular)
    }
}
