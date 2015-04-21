//
//  Calculator.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 21/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import Foundation

class Calculator {
    
    func calculateVariables() {
    currentDataRate = calculateDataRate(currentDataRate, resMultiplier: currentResMultiplier!)
    currentGigaBytesPerDay = calculateGigaBytesPerDay(self.stepper.value, dataRate: currentDataRate)
    currentNumberOfDays = calculateNumberOfDays(currentHDDGB!, hddNumber: currentNumberOfHDD!, gbPerDay: currentGigaBytesPerDay)
    currentNumberOfMonths = calculateNumberOfMonths(self.currentNumberOfMonths)
    currentNumberOfYears = calculateNumberOfYears(self.currentNumberOfYears)
    outputTableView.reloadData()
    
    }
    
    //declare DVR class
    struct dvr {
        //properties
        let modelName : String, numberOfChannels : Int
        
        
        
        //initialise
        init (modelName: String, numberOfChannels: Int) {
            self.modelName = modelName
            self.numberOfChannels = numberOfChannels
            
        }
    }
    
    //Calculations
    
    //calculate current data rate
    var currentDataRate : Double = 0
    
    func calculateDataRate(baseRate : Double, resMultiplier : Double) -> Double {
        
        //store current data rate
        var currentDataRate : Double = currentBaseRate! * currentResMultiplier!
        
        return currentDataRate
    }
    
    //calculate current Gigabytes per day
    var currentGigaBytesPerDay : Double = 0
    
    func calculateGigaBytesPerDay(noCameras : Double, dataRate : Double) -> Double {
        
        var currentGigaBytesPerDay = stepper.value * ((currentDataRate / 8) * 0.086400)
        
        return Double(round(100*currentGigaBytesPerDay)/100) //round to 2 decimal places
        
    }
    
    //caluclate number of days
    var currentNumberOfDays : Double = 0
    func calculateNumberOfDays (hddSize : Int, hddNumber : Int, gbPerDay : Double) -> Double {
        
        var numberOfDays = (Double(self.currentHDDGB!) * Double(self.currentNumberOfHDD!)) / Double(currentGigaBytesPerDay)
        return Double(round(100*numberOfDays)/100) //round to 2 decimal places
    }
    
    //calculate number of months
    var currentNumberOfMonths : Double = 0
    func calculateNumberOfMonths(numberOfMonths : Double) -> Double {
        
        var numberOfMonths = self.currentNumberOfDays / 30
        return Double(round(100*numberOfMonths)/100) //round to 2 decimal places
    }
    
    //calculate number of years
    var currentNumberOfYears : Double = 0
    func calculateNumberOfYears(numberOfDays : Double) -> Double {
        var numberOfYears = self.currentNumberOfDays / Double(year)
        return Double(round(100*numberOfYears)/100) //round to 2 decimal places
    }
    
    //DECLARE VARIABLES
    
    //current date
    let year : Int = 365
    
    //calculation variables
    
    //calculate base rate variables
    let baseRate = [32.0,48.0,96.0,128.0,192.0,224.0,256.0,384.0,448.0,512.0]
    var currentBaseRate : Double?
    //calculate res multiplier variables
    let resMultiplier = [0.25,1,2,4,8,20]
    var currentResMultiplier : Double?
    
    
    //resolution variables
    let arrayResolution = ["QCIF","CIF","2CIF","4CIF","720p","1080p"]
    let arrayResolutionNum = [176*144,352*240,704*240,704*480,1280*720,1920*1080]
    var currentResolution : Int?
    
    //framerate variables
    let frameRate = [1,2,4,6,8,10,12,16,20,25]
    var currentFrameRate : Int?
    
    //instantiate an instance of dvr
    let alien654:dvr = dvr(modelName: "ALIEN Hero", numberOfChannels: 4)
    
    //HDD size
    let hddGB : [Int] = [4,8,16,32,64,128,160,250,320,400,500,640,750,1000,1200,1500,2000,3000,4000,6000]
    let hddString = ["4GB","8GB","16GB","32GB","64GB","128GB","160GB","250GB","320GB","400GB","500GB","640GB","750GB","1TB","1.2TB","1.5TB","2TB","3TB","4TB","6TB"]
    var currentHDDGB : Int?
    
    //number of HDD
    let numberOfHDD = [Int](1...8)
    var currentNumberOfHDD : Int?
    
    //array of data values
    let arrayValueStrings = ["Data Rate in kb/s","Gigabytes per day","Number of days (Approx)","Number of months (Approx)","Number of years (Approx)"]

}
