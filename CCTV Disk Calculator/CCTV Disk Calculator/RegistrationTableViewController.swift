//
//  RegistrationTableViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 03/05/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    struct formValues {
        var firstName: String = RegistrationTableViewController().firstNameTextField.description
        var lastName: String = RegistrationTableViewController().lastNameTextField.description
        var email: String = RegistrationTableViewController().emailTextField.description
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField {
        case firstNameTextField:
            textField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
        default:
            true
        }
        
        return true
    }
}
