//
//  DigitalVideoRecorder.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 22/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import Foundation

struct Resolution {
    var width = 0
    var height = 0
}

class DigitalVideoRecorder {
    let numberOfHardDrives : Int
    let frameRates : [Int]
    let hardDriveCapacities : [Int]
    let resolutions : [Int]
    
    init(numberOfHardDrives : Int, frameRates : [Int], hardDriveCapacities : [Int], resolutions : [Int]) {
        self.numberOfHardDrives = numberOfHardDrives
        self.frameRates = frameRates
        self.hardDriveCapacities = hardDriveCapacities
        self.resolutions = resolutions
    }
    
}
