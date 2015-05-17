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
    @IBOutlet weak var submitButton: UIBarButtonItem!
    
    func submitButtonShow(firstNameTextField: UITextField, lastNameTextField: UITextField, emailTextField: UITextField) {
        if firstNameTextField.text.isEmpty || lastNameTextField.text.isEmpty || emailTextField.text.isEmpty {
            submitButton.enabled = false
        } else  {
            submitButton.enabled = true
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButtonShow(firstNameTextField, lastNameTextField: lastNameTextField, emailTextField: emailTextField)
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitPress(sender: AnyObject) {
        var registration = RegistrationDetails(firstName: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text)
        println("\(registration.firstName, registration.lastName, registration.email)")
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        switch textField {
        case firstNameTextField:
            textField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
            submitButtonShow(firstNameTextField, lastNameTextField: lastNameTextField, emailTextField: emailTextField)
        case emailTextField:
            emailTextField.resignFirstResponder()
            submitButtonShow(firstNameTextField, lastNameTextField: lastNameTextField, emailTextField: emailTextField)
        default:
            true
        }
        
        return true
    }
}