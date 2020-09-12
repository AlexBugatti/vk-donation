//
//  DonationWizardModel.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationWizardModel {

    enum ViewType {
        case textfield
        case inputimage
        case dropdown
    }
    
    var order: Int
    var title: String
    var value: String?
    var image: UIImage?
    var keyboardType: UIKeyboardType? = .default
    var subtitle: String
    var viewType: ViewType
    var identifier: String
    
    init(order: Int, title: String, subtitle: String, value: String? = nil, type: ViewType, identifier: String) {
        self.order = order
        self.title = title
        self.subtitle = subtitle
        self.viewType = type
        self.value = value
        self.identifier = identifier
    }
    
    
    func getView() -> (UIView & Wizardable) {
        switch self.viewType {
            case .textfield: return TextFieldView()
            case .inputimage: return InputImageView()
            case .dropdown: return LabelFieldView()
        }
    }
    
    class func additional() -> [DonationWizardModel] {
        
        var items: [DonationWizardModel] = []
        
        let author = DonationWizardModel(order: 6, title: "Автор", subtitle: "М", value: "Матвей Правосудов", type: .dropdown, identifier: "author")
        items = [author]
        
        return items
    }
    
    class func target() -> [DonationWizardModel] {
        
        var items: [DonationWizardModel] = []
        
        let inputImage = DonationWizardModel(order: 0, title: "InputImage", subtitle: "", type: .inputimage, identifier: "image")
        let title = DonationWizardModel(order: 1, title: "Название сбора", subtitle: "Название сбора", type: .textfield, identifier: "title")
        let summary = DonationWizardModel(order: 2, title: "Сумма", subtitle: "Сколько нужно собрать?", type: .textfield, identifier: "price")
        summary.keyboardType = .numberPad
        
        let target = DonationWizardModel(order: 3, title: "Цель", subtitle: "Например, лечение целовека", type: .textfield, identifier: "target")
        let description = DonationWizardModel(order: 4, title: "Описание", subtitle: "На что пойдут деньги, и как они кому-то помогут?", type: .textfield, identifier: "description")
        let card = DonationWizardModel(order: 5, title: "Куда получать деньги", subtitle: "С", value: "Счет VK Pay • 1234", type: .dropdown, identifier: "card")
        items = [inputImage, title, summary, target, description, card]
        
        return items
    }
    
    class func regular() -> [DonationWizardModel] {
        
        var items: [DonationWizardModel] = []
        
                let inputImage = DonationWizardModel(order: 0, title: "InputImage", subtitle: "", type: .inputimage, identifier: "image")
        let title = DonationWizardModel(order: 1, title: "Название сбора", subtitle: "Название сбора", type: .textfield, identifier: "title")
        let summary = DonationWizardModel(order: 2, title: "Сумма", subtitle: "Сколько нужно собрать?", type: .textfield, identifier: "price")
        summary.keyboardType = .numberPad
        let target = DonationWizardModel(order: 3, title: "Цель", subtitle: "Например, лечение целовека", type: .textfield, identifier: "target")
        
        let description = DonationWizardModel(order: 4, title: "Описание", subtitle: "На что пойдут деньги, и как они кому-то помогут?", type: .textfield, identifier: "description")
        let card = DonationWizardModel(order: 5, title: "Куда получать деньги", subtitle: "С", value: "Счет VK Pay • 1234", type: .dropdown, identifier: "card")
        let author = DonationWizardModel(order: 6, title: "Автор", subtitle: "М", value: "Матвей Правосудов", type: .dropdown, identifier: "author")
        items = [inputImage, title, summary, target, description, card, author]
        
        return items
    }
    
}
