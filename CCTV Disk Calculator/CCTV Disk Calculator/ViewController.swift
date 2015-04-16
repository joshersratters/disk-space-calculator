//
//  ViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 29/03/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        
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
    
   
    //calculate current data rate
    var currentDataRate : Double = 8.0
    
    func calculateDataRate(baseRate : Double, resMultiplier : Double) -> Double {
        
        //store current data rate
        var currentDataRate : Double = currentBaseRate * currentResMultiplier
        
        return currentDataRate
    }
    
    //calculate current Gigabytes per day
    var currentGigaBytesPerDay : Double = 0
    
    func calculateGigaBytesPerDay(noChannels : Int, dataRate : Double) -> Double {
        
        return 0
    }
    
    //DECLARE VARIABLES
    
    
    //calculation variables
    
    //calculate base rate variables
    let baseRate = [32.0,48.0,96.0,128.0,192.0,224.0,256.0,384.0,448.0,512.0]
    var currentBaseRate : Double = 32.0
    //calculate res multiplier variables
    let resMultiplier = [0.25,1,2,4,8,20]
    var currentResMultiplier : Double = 0.25
    
    
    //resolution variables
    let arrayResolution = ["1080p","720p","4CIF","2CIF","CIF","QCIF"].reverse()
    let arrayResolutionNum = [1920*1080,1280*720,704*480,704*240,352*240,176*144].reverse()
    var currentResolution : Int = 176*144
    
    //framerate variables
    let frameRate = [1,2,4,6,8,10,12,16,20,25]
    var currentFrameRate : Int = 1
    
    //instantiate an instance of dvr
    let alien654:dvr = dvr(modelName: "ALIEN Hero", numberOfChannels: 4)
    
    //HDD size
    let hddGB = [4,8,16,32,64,128,160,250,320,400,500,640,750,1000,1200,1500,2000,3000,4000,6000]
    let hddString = ["4GB","8GB","16GB","32GB","64GB","128GB","160GB","250GB","320GB","400GB","500GB","640GB","750GB","1TB","1.2TB","1.5TB","2TB","3TB","4TB","6TB"]
    var currentHDDGB : Int = 4
    
    //number of HDD
    let numberOfHDD = [Int](1...8)
    var currentNumberOfHDD : Int = 1
    
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
        
        //Put particular row detail text to a variable
        switch indexPath.row {
        case 0:
            cell.detailTextLabel!.text = currentDataRate.description
        default:
            cell.detailTextLabel!.text = 0.description
            
        }
        
        if indexPath.section == 0 {
            let valueStrings = arrayValueStrings[indexPath.row]
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
            return self.hddGB.count
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
            return self.hddString[row]
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
            currentHDDGB = hddGB[row]
            println("The current HDD GB value is \(currentHDDGB)")
        case 3:
            currentNumberOfHDD = numberOfHDD[row]
            println("The current number of HDD's is \(currentNumberOfHDD)")
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

