//
//  ViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 29/03/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    //DECLARE VARIABLE
    var dataValues = ConstantVariables()
    
    var currentDataRate : Double = 0
    var currentGigaBytesPerDay : Double = 0
    var currentNumberOfDays : Double = 0
    var currentNumberOfMonths : Double = 0
    var currentNumberOfYears : Double = 0
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        currentNumberOfCameras.text = Int(stepper.value).description
        calculateVariables()
    }
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var currentNumberOfCameras: UILabel!
    @IBOutlet weak var detailPicker: UIPickerView!
    @IBOutlet weak var outputTableView: UITableView!
    
    @IBAction func resetInputValues(sender: AnyObject) {
        for var i = 0; i < numberOfComponentsInPickerView(detailPicker); i++ {
            detailPicker.selectRow(0, inComponent: i, animated: true)
        }
        
        initialiseInputVariables()
        resetValuesInTableView()
        calculateVariables()
    }
    
    
    @IBAction func pressTechnicalTips(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.aliendvr.com/support")!)
    }
    
    
    func calculateVariables() {
        let calculator = Calculator(baseDataRate: dataValues.currentBaseRate!, resolutionMultiplier: dataValues.currentResMultiplier!, numberOfCameras: stepper.value, hardDriveCapacity: dataValues.currentHDDGB!, numberOfHardDrives: dataValues.currentNumberOfHDD!)
        
        currentDataRate = calculator.getDataRate()
        currentGigaBytesPerDay = calculator.getGigabytesPerDay()
        currentNumberOfDays = calculator.getNumberOfDays()
        currentNumberOfMonths = calculator.getNumberOfMonths()
        currentNumberOfYears = calculator.getNumberOfYears()
        
      
        
        outputTableView.reloadData()
    }
    
    // Table section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return dataValues.ValueStrings.count
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
            let valueStrings = dataValues.ValueStrings[indexPath.row]
            cell.textLabel?.text = valueStrings
        } else if indexPath.section == 1 {
            return cell
            
        }
        
       
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Calculations"
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
            return ConstantVariables().resolution.count
        case 1:
            return ConstantVariables().frameRate.count
        case 2:
            return ConstantVariables().hddGB.count
        case 3:
            return ConstantVariables().numberOfHDD.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        switch component {
        case 0:
            return ConstantVariables().resolution[row].0
        case 1:
            return " \(ConstantVariables().frameRate[row].description) fps"
        case 2:
            return ConstantVariables().hddGB[row].0
        case 3:
            return "\(self.dataValues.numberOfHDD[row]) HDD"
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        switch component {
        case 0:
            dataValues.currentResolution = ConstantVariables().resolution[row].1
            dataValues.currentResMultiplier = ConstantVariables().resMultiplier[row]
            calculateVariables()
        case 1:
            dataValues.currentFrameRate = ConstantVariables().frameRate[row]
            dataValues.currentBaseRate = ConstantVariables().baseRate[row]
            calculateVariables()
        case 2:
            dataValues.currentHDDGB = ConstantVariables().hddGB[row].1
            calculateVariables()
        case 3:
            dataValues.currentNumberOfHDD = ConstantVariables().numberOfHDD[row]
            calculateVariables()
        default:
           break
        }
        
    }
    //end picker view code
    
    
    func initialiseInputVariables() {
        dataValues.currentHDDGB = ConstantVariables().hddGB.first!.1
        dataValues.currentBaseRate = ConstantVariables().baseRate.first
        dataValues.currentFrameRate = ConstantVariables().frameRate.first
        dataValues.currentNumberOfHDD = ConstantVariables().numberOfHDD.first
        dataValues.currentResMultiplier = ConstantVariables().resMultiplier.first
        dataValues.currentResolution = ConstantVariables().resolution.first!.1
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
        calculateVariables()
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

