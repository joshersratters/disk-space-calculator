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
    let numberOfCameras: Double
    let hardDriveCapacity: Int
    let numberOfHardDrives: Int
    
    init(baseDataRate: Double, resolutionMultiplier: Double, numberOfCameras: Double, hardDriveCapacity: Int, numberOfHardDrives: Int) {
        self.baseDataRate = baseDataRate
        self.resolutionMultiplier = resolutionMultiplier
        self.numberOfCameras = numberOfCameras
        self.hardDriveCapacity = hardDriveCapacity
        self.numberOfHardDrives = numberOfHardDrives
    }
    
    func getDataRate() -> Double {
        var dataRate = baseDataRate * resolutionMultiplier
        return dataRate
    }
    
    func getGigabytesPerDay() -> Double {
        var gigabytesPerDay = numberOfCameras * ((getDataRate() / 8) * 0.086400)
        gigabytesPerDay = roundDouble(gigabytesPerDay)
        return gigabytesPerDay
    }
    
    func getNumberOfDays() -> Double {
        var numberOfDays = (Double(hardDriveCapacity) * Double(numberOfHardDrives)) / Double(getGigabytesPerDay())
        numberOfDays = roundDouble(numberOfDays)
        return numberOfDays
    }

    func getNumberOfMonths() -> Double {
        var numberOfMonths = getNumberOfDays() / 30
        numberOfMonths = roundDouble(numberOfMonths)
        return numberOfMonths
    }
    
    func getNumberOfYears() -> Double {
        var numberOfYears = getNumberOfDays() / Double(365)
        numberOfYears = roundDouble(numberOfYears)
        return numberOfYears
    }
    
    func roundDouble(double: Double) -> Double {
        return round(100 * double) / 100
    }
}
