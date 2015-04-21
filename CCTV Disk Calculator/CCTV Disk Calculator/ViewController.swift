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
        currentNumberOfCameras.text = Int(stepper.value).description
        println("The current stepper value is \(Int(stepper.value))") //stepper value double as int
    }
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var currentNumberOfCameras: UILabel!
    @IBOutlet weak var detailPicker: UIPickerView!
    @IBOutlet weak var outputTableView: UITableView!

    @IBAction func calculateVariables(sender: AnyObject) {
        currentDataRate = calculateDataRate(currentDataRate, resMultiplier: currentResMultiplier!)
        currentGigaBytesPerDay = calculateGigaBytesPerDay(self.stepper.value, dataRate: currentDataRate)
        currentNumberOfDays = calculateNumberOfDays(currentHDDGB!, hddNumber: currentNumberOfHDD!, gbPerDay: currentGigaBytesPerDay)
        currentNumberOfMonths = calculateNumberOfMonths(self.currentNumberOfMonths)
        currentNumberOfYears = calculateNumberOfYears(self.currentNumberOfYears)
        outputTableView.reloadData()
    }
    
    @IBAction func resetInputValues(sender: AnyObject) {
        for var i = 0; i < numberOfComponentsInPickerView(detailPicker); i++ {
            detailPicker.selectRow(0, inComponent: i, animated: true)
        }
        
        initialiseInputVariables()
        resetValuesInTableView()
    }
    
    
    @IBAction func pressTechnicalTips(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.aliendvr.com/support")!)
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
        case 1:
            cell.detailTextLabel!.text = currentGigaBytesPerDay.description
        case 2:
            cell.detailTextLabel!.text = currentNumberOfDays.description
        case 3:
            cell.detailTextLabel!.text = currentNumberOfMonths.description
        case 4:
            cell.detailTextLabel!.text = currentNumberOfYears.description
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
        // Return 4 columns
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
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        switch component {
        case 0:
            currentResolution = arrayResolutionNum[row]
            currentResMultiplier = resMultiplier[row]
            println("The current resolution is \(currentResolution) and res multiplier is \(currentResMultiplier)")
        case 1:
            currentFrameRate = frameRate[row]
            currentBaseRate = baseRate[row]
            println("FPS value is \(currentFrameRate) and base rate is \(currentBaseRate)")
        case 2:
            currentHDDGB = hddGB[row]
            println("The current HDD GB value is \(currentHDDGB!)")
        case 3:
            currentNumberOfHDD = numberOfHDD[row]
            println("The current number of HDD's is \(currentNumberOfHDD!)")
        default:
            println("Not sure...")
        }
        
    }
    
   
    

    // end picker view code
    
    
    func initialiseInputVariables() {
        currentHDDGB = hddGB.first
        currentBaseRate = baseRate.first
        currentFrameRate = frameRate.first
        currentNumberOfHDD = numberOfHDD.first
        currentResMultiplier = resMultiplier.first
        currentResolution = arrayResolutionNum.first
    }
    
    func resetValuesInTableView() {
        currentDataRate = 0
        currentGigaBytesPerDay = 0
        currentNumberOfDays = 0
        currentNumberOfMonths = 0
        currentNumberOfYears = 0
        outputTableView.reloadData()
        stepper.value = 1; currentNumberOfCameras.text = Int(stepper.value).description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseInputVariables()
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

