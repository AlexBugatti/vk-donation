//
//  DonationTypeController.swift
//  vk-donations
//
//  Created by Александр on 11.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class DonationTypeController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    var types: [DonationTypeModel] {
        return [DonationTypeModel.target, DonationTypeModel.regular]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.showSeparateView()
        self.navigationItem.title = "Тип сбора"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        stackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        types.forEach { (model) in
            let donationTypeView = DonationTypeView()
            donationTypeView.setupUI(typeNodel: model)
            donationTypeView.didActionTapped = {
                self.showDonationWizard(type: model)
            }
            self.stackView.addArrangedSubview(donationTypeView)
        }
    }
    
    func showDonationWizard(type: DonationTypeModel) {
        self.performSegue(withIdentifier: "toWizard", sender: type)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toWizard", let wizardVC = segue.destination as? DonationWizardController {
            wizardVC.type = sender as? DonationTypeModel
        }
        
    }


}
