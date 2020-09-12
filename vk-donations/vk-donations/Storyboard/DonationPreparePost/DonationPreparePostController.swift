//
//  DonationPreparePostController.swift
//  vk-donations
//
//  Created by Александр on 12.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationPreparePostController: UIViewController {

    @IBOutlet weak var navigationbBarView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var snippetView: DonationSnippetView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var donation: Donation?
    private var observers = [NSObjectProtocol]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showSeparateView()
        if let don = self.donation {
            snippetView.setupUI(donation: don)
        }
        textView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    
    func showSeparateView() {
        
        navigationbBarView.subviews.forEach { (view) in
            if view.tag == 234 {
                return
            }
        }
        
        let separateView = UIView()
        separateView.backgroundColor = #colorLiteral(red: 0.8438933492, green: 0.8473063111, blue: 0.8505352736, alpha: 1)
        separateView.tag = 234
        separateView.translatesAutoresizingMaskIntoConstraints = false
        separateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        navigationbBarView.addSubview(separateView)
        let constraints = [navigationbBarView.bottomAnchor.constraint(equalTo: separateView.bottomAnchor),
                           separateView.leadingAnchor.constraint(equalTo: navigationbBarView.leadingAnchor, constant: 12),
                           navigationbBarView.trailingAnchor.constraint(equalTo: separateView.trailingAnchor, constant: 12)
                        ]
        NSLayoutConstraint.activate(constraints)
        navigationbBarView.layoutIfNeeded()
    }

    @IBAction func onDidDismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDidPostSaveTapped(_ sender: Any) {
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

extension DonationPreparePostController {
    
    // MARK: - Keyboard Observations
    
    func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        
        let willShowObserver = center.addObserver(with: UIViewController.keyboardWillShow) { payload in
            self.bottomConstraint.constant = payload.endFrame.height
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { (success) in
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
