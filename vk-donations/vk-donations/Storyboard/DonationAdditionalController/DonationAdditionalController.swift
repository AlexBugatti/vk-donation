//
//  DonationAdditionalController.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationAdditionalController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var fields: [DonationWizardModel] = []
    
    private var observers = [NSObjectProtocol]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
        self.navigationItem.title = "Дополнительно"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterKeyboardNotifications()
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DonationAdditionalController {
    
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
