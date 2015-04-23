//
//  CurrentValues.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 23/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import Foundation

class CurrentValues {
    var currentDataRate : Double
    var currentGigaBytesPerDay : Double
    var currentNumberOfDays : Double
    var currentNumberOfMonths : Double
    var currentNumberOfYears : Double
    
    init(currentDataRate: Double, currentGigaBytesPerDay: Double, currentNumberOfDays : Double, currentNumberOfMonths : Double, currentNumberOfYears : Double) {
        self.currentDataRate = currentDataRate
        self.currentGigaBytesPerDay = currentGigaBytesPerDay
        self.currentNumberOfDays = currentNumberOfDays
        self.currentNumberOfMonths = currentNumberOfMonths
        self.currentNumberOfYears = currentNumberOfYears
    }
    
    
    
    
    
    
    
}

struct ConstantVariables {
    //CONSTANTS
    //table view titles
    let ValueStrings = ["Data Rate in kb/s","Gigabytes per day","Number of days (Approx)","Number of months (Approx)","Number of years (Approx)"]
    //number of HDD
    let numberOfHDD = [Int](1...8)
    //HDD size
    let hddGB = [("1TB",1000),("2TB",2000),("3TB",3000),("4TB",4000),("6TB",6000)]
    //framerate
    let frameRate = [1,2,4,6,8,10,12,16,20,25]
    //resolution
    let resolution = [("QCIF",176*144),("CIF",352*240),("2CIF",704*240),("4CIF",704*480),("720p",1280*720),("1080p",1920*1080)]
    //calculate res multiplier variables
    let resMultiplier = [0.25,1,2,4,8,20]
    //calculate base rate variables
    let baseRate = [32.0,48.0,96.0,128.0,192.0,224.0,256.0,384.0,448.0,512.0]
    
    //VARIABLES
    var currentNumberOfHDD : Int?
    var currentHDDGB : Int?
    var currentFrameRate : Int?
    var currentResolution : Int?
    var currentResMultiplier : Double?
    var currentBaseRate : Double?
}