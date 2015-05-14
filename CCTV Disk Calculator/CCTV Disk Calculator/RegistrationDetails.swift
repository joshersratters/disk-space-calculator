//
//  RegistrationDetails.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 14/05/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import Foundation

class RegistrationDetails {
    let firstName: String?
    let lastName: String?
    let email: String?
    
    func validation(firstName: String) -> Bool {
        if firstName.isEmpty  {
            return false
        }
        return true
    }
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}