//
//  ViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 29/03/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
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
    
   
    //calculate current data rate
    func calculateDataRate(baseRate : Double, resMultiplier : Double) -> Double {
        
        //store current data rate
        var currentDataRate : Double = currentBaseRate * currentResMultiplier
        
        return currentDataRate
    }
    
    //DECLARE VARIABLES
    
    
    //calculation variables
    
    //calculate base rate variables
    let baseRate = [32.0,48.0,96.0,128.0,192.0,224.0,256.0,384.0,448.0,512.0]
    var currentBaseRate : Double = 32.0
    //calculate res multiplier variables
    let resMultiplier = [0.25,1,2,4,8,20]
    var currentResMultiplier : Double = 0.25
   
    var currentDataRate : Double = 8.0
   
    
    //resolution variables
    let arrayResolution = ["Full HD","HD","4CIF","2CIF","CIF","QCIF"].reverse()
    let arrayResolutionNum = [1920*1080,1280*720,704*480,704*240,352*240,176*144].reverse()
    var currentResolution : Int = 0
    
    //framerate variables
    let frameRate = [1,2,4,6,8,10,12,16,20,25]
    var currentFrameRate : Int = 0
    
    //instantiate an instance of dvr
    let alien654:dvr = dvr(modelName: "ALIEN Hero", numberOfChannels: 4)
    
    //HDD size
    let hddMB = [4,8,16,32,64,128,160,250,320,400,500,640,750,1000,1200,1500,2000,3000,4000]
    var currentHDDMB : Int?
    
    //number of HDD
    let numberOfHDD = [Int](1...10)
    var currentNumberOfHDD : Int?
    
    //number of cameras (using a closure range operator)
    let numberOfCameras = [Int](1...100)
    var currentNumberOfCameras : Int?
    
    //array of data values
    let arrayValueStrings = ["Data Rate in kb/s","Gigabytes per day","Number of days","Number of months","Number of years"]
    
   
    
    
    // Table section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return arrayValueStrings.count
        } else {
            return section
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.detailTextLabel?.text = self.currentDataRate.description
        
        if indexPath.section == 0 {
            let (valueStrings) = arrayValueStrings[indexPath.row]
            cell.textLabel?.text = valueStrings
        } else if indexPath.section == 1 {
            return cell
            
        }
        
       
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CALCULATIONS"
        } else if section == 1 {
            return "Metrics"
        } else {
            return nil
        }
    }
    
    // end table code
    
    
    // Picker view code
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        // Return 2 columns
        return 4
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return self.arrayResolution.count
        case 1:
            return self.frameRate.count
        case 2:
            return self.hddMB.count
        case 3:
            return numberOfHDD.count
        case 4:
            return numberOfCameras.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        switch component {
        case 0:
            return self.arrayResolution[row]
        case 1:
            return " \(self.frameRate[row].description) fps"
        case 2:
            return "\(self.hddMB[row].description) MB"
        case 3:
            return "\(self.numberOfHDD[row]) HDD"
        case 4:
            return "\(self.numberOfCameras[row]) Cameras"
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        switch component {
        case 0:
            currentResolution = arrayResolutionNum[row]
            currentResMultiplier = resMultiplier[row]
            currentDataRate = calculateDataRate(currentDataRate, resMultiplier: currentResMultiplier)
            println("The current resolution is \(currentResolution) and res multiplier is \(currentResMultiplier)")
            println("The current data rate is \(currentDataRate)")
            
        case 1:
            currentFrameRate = frameRate[row]
            currentBaseRate = baseRate[row]
            currentDataRate = calculateDataRate(currentDataRate, resMultiplier: currentResMultiplier)
            println("FPS value is \(currentFrameRate) and base rate is \(currentBaseRate)")
            println("The current data rate is \(currentDataRate)")
            
        case 2:
            currentHDDMB = hddMB[row]
            println("The current HDD MB value is \(currentHDDMB!)")
        case 3:
            currentNumberOfHDD = numberOfHDD[row]
            println("The current number of HDD's is \(currentNumberOfHDD!)")
        case 4:
            currentNumberOfCameras = numberOfCameras[row]
            println("The number of cameras is \(currentNumberOfCameras!)")
        default:
            println("Not sure...")
        }
        
    }
    
    
    

    // end picker view code
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view, typically from a nib.
        
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

