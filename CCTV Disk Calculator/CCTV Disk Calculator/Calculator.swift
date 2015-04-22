//
//  Calculator.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 21/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import Foundation

class Calculator {
    let baseDataRate: Double
    let resolutionMultiplier: Double
    let numberOfCameras: Int
    let hardDriveCapacity: Int
    let numberOfHardDrives: Int
    let gigabytesPerDay: Double
    
    init(baseDataRate: Double, resolutionMultiplier: Double, numberOfCameras: Int, hardDriveCapacity: Int, numberOfHardDrives: Int, gigabytesPerDay: Double) {
        self.baseDataRate = baseDataRate
        self.resolutionMultiplier = resolutionMultiplier
        self.numberOfCameras = numberOfCameras
        self.hardDriveCapacity = hardDriveCapacity
        self.numberOfHardDrives = numberOfHardDrives
        self.gigabytesPerDay = gigabytesPerDay
    }
}
