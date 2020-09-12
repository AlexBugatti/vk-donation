//
//  MainTextView.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class MainTextView: NibView {

    var placeholderText: String = "Введите текст" {
        didSet {
            self.textView?.text = self.placeholderText
        }
    }
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.layer.cornerRadius = Constants.textfieldCornerRadius
            self.containerView.layer.masksToBounds = true
            self.containerView.layer.borderColor = Pallete.textfieldBorderColor.cgColor
            self.containerView.layer.borderWidth = 0.5
            self.containerView.backgroundColor = Pallete.textfieldBackground
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            self.textView.textContainerInset = .zero
            self.textView.textContainer.lineFragmentPadding = 0.0
            self.textView.delegate = self
            self.textView.text = placeholderText
            self.textView.textColor = Pallete.subtitle
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension MainTextView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Pallete.subtitle {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = Pallete.subtitle
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if textView.text == placeholderText {
//            textView.text = ""
//            textView.textColor = Pallete.subtitle
//        }
//        return true
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = placeholderText
//            textView.textColor = .black
//        }
//    }
    
}
