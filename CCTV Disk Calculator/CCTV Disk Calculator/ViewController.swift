//
//  ViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 29/03/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {
    var numberOfHardDrives: Int = 0
    var hardDriveCapacity: Int = 0
    var frameRate: Int = 0
    var resolution: Int = 0
    var resolutionMultiplier: Double = 0
    var baseDataRate: Double = 0
    
    var dataRate: Double = 0
    var gigabytesPerDay: Double = 0
    var numberOfDays: Double = 0
    var numberOfMonths: Double = 0
    var numberOfYears: Double = 0
    
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var numberOfCamerasLabel: UILabel!
    @IBOutlet weak var detailPicker: UIPickerView!
    @IBOutlet weak var outputTableView: UITableView!
    
    
    @IBAction func resetInputValues(sender: AnyObject) {
        for var i = 0; i < numberOfComponentsInPickerView(detailPicker); i++ {
            detailPicker.selectRow(0, inComponent: i, animated: true)
        }
        
        stepper.value = 1; numberOfCamerasLabel.text = (Int(stepper.value)).description
        initialiseInputVariables()
        calculate()
    }
    
    @IBAction func displayTechnicalTips(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.aliendvr.com/support")!)
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        numberOfCamerasLabel.text = (Int(stepper.value)).description
        calculate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseInputVariables()
        calculate()
    }
    
    
    func initialiseInputVariables() {
        hardDriveCapacity = Constants().hardDriveCapacities.first!.int
        baseDataRate = Constants().baseDataRates.first!
        frameRate = Constants().frameRates.first!
        numberOfHardDrives = Constants().numberOfHardDrives.first!
        resolutionMultiplier = Constants().resolutionMultipliers.first!
        resolution = Constants().resolutions.first!.value
    }
    
    func calculate() {
        let calculator = Calculator(baseDataRate: baseDataRate, resolutionMultiplier: resolutionMultiplier, numberOfCameras: stepper.value, hardDriveCapacity: hardDriveCapacity, numberOfHardDrives: numberOfHardDrives)
        
        dataRate = calculator.getDataRate()
        gigabytesPerDay = calculator.getGigabytesPerDay()
        numberOfDays = calculator.getNumberOfDays()
        numberOfMonths = calculator.getNumberOfMonths()
        numberOfYears = calculator.getNumberOfYears()
        
        outputTableView.reloadData()
    }
    
    
    // Begin UITableView Code
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Constants().tableViewTitles.count
        } else {
            return section
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Set row detail text to relevant variable
        switch indexPath.row {
        case 0:
            cell.detailTextLabel!.text = dataRate.description
        case 1:
            cell.detailTextLabel!.text = gigabytesPerDay.description
        case 2:
            cell.detailTextLabel!.text = numberOfDays.description
        case 3:
            cell.detailTextLabel!.text = numberOfMonths.description
        case 4:
            cell.detailTextLabel!.text = numberOfYears.description
        default:
            cell.detailTextLabel!.text = 0.description
        }
        
        if indexPath.section == 0 {
            let cellTitles = Constants().tableViewTitles[indexPath.row]
            cell.textLabel?.text = cellTitles
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
    // End UITableView Code
    
    
    // Begin UIPickerView Code
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return Constants().resolutions.count
        case 1:
            return Constants().frameRates.count
        case 2:
            return Constants().hardDriveCapacities.count
        case 3:
            return Constants().numberOfHardDrives.count
        default:
            return 0
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        switch component {
        case 0:
            return Constants().resolutions[row].name
        case 1:
            return " \(Constants().frameRates[row].description) fps"
        case 2:
            return Constants().hardDriveCapacities[row].string
        case 3:
            return "\(Constants().numberOfHardDrives[row]) HDD"
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  
        switch component {
        case 0:
            resolution = Constants().resolutions[row].value
            resolutionMultiplier = Constants().resolutionMultipliers[row]
            calculate()
        case 1:
            frameRate = Constants().frameRates[row]
            baseDataRate = Constants().baseDataRates[row]
            calculate()
        case 2:
            hardDriveCapacity = Constants().hardDriveCapacities[row].int
            calculate()
        case 3:
            numberOfHardDrives = Constants().numberOfHardDrives[row]
            calculate()
        default:
           break
        }
    }
    // End UIPickerView Code
}

