//
//  DonateViewController.swift
//  Watsi
//
//  Created by Jeremy Levy on 15/05/2017.
//  Copyright © 2017 Jeremy Levy. All rights reserved.
//

import UIKit

class DonateViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Interface builder
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var donateBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.closeMyself()
    }
    
    @IBAction func donate(_ sender: UIBarButtonItem) {
        self.amountTextField.resignFirstResponder()
        
        LoadingOverlay.shared.showOverlay(view: self.navigationController?.view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            LoadingOverlay.shared.hideOverlayView()
            
            self.patientProfilVC.showDonateAmountLabel(withAmount: Int(self.amountTextField.text!)!)
            
            self.closeMyself()
        })
    }
    
    @IBAction func amountTextFieldDidChange(_ sender: UITextField) {
        let amountLength = self.amountTextField.text?.characters.count
        
        self.donateBarButtonItem.isEnabled = amountLength ?? 0 > 0
        
        if amountLength != nil && amountLength! > 0 {
            self.dollarLabel.textColor = Color.donateVCDollarLabelEnabledColor()
        } else {
            self.dollarLabel.textColor = Color.donateVCDollarLabelDisabledColor()
        }
    }
    
    // MARK: - Custom properties
    
    private let amountMaxLength = 3
    
    weak var patientProfilVC: PatientProfilTableViewController!
    
    // MARK: - View controller lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureAmountTextField()
        
        self.configureDonateBarButtonItem()
        
        self.configureNavigationBar()
    }
    
    // MARK: - Custom methods
    
    func configureView() {
        self.view.backgroundColor = Color.windowBgColor()
    }
    
    func configureAmountTextField() {
        // Display keyboard on load
        self.amountTextField.becomeFirstResponder()
    }
    
    func configureDonateBarButtonItem() {
        // Wait until amount was filled
        self.donateBarButtonItem.isEnabled = false
        
        self.donateBarButtonItem.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16.0)],
                                                        for: .normal)
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "Effectuer un don"
        
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Color.navigationBarTitleTextColor()]
        self.navigationController?.navigationBar.barTintColor = Color.navigationBarBackgroundColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func closeMyself() {
        // Hide keyboard
        self.amountTextField.resignFirstResponder()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // We only want numbers
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        // We want amount length to be less than or equal to `amountMaxLength`
        let currentCharacterCount = textField.text?.characters.count ?? 0
        
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        if (newLength > self.amountMaxLength) {
            return false
        }
        
        // We not want amount number to be started by `0`
        if range.location == 0 && string.hasPrefix("0") {
            return false
        }
        
        return true
    }
}
