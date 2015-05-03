//
//  ViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 29/03/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate {
    var numberOfHardDrives: Int = 0
    var hardDriveCapacity: (value:Int, name: String) = (0, "nothing")
    var frameRate: Int = 0
    var resolution: (value: Int, name: String) = (0, "nothing")
    var resolutionMultiplier: Double = 0
    var baseDataRate: Double = 0
    
    var dataRate: Double = 0
    var gigabytesPerDay: Double = 0
    var numberOfDays: Double = 0
    var numberOfMonths: Double = 0
    var numberOfYears: Double = 0
    
    
    
    
    @IBOutlet weak var hardDiskStepper: UIStepper!
    @IBOutlet weak var numberOfHardDrivesLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var numberOfCamerasLabel: UILabel!
    @IBOutlet weak var detailPicker: UIPickerView!
    @IBOutlet weak var outputTableView: UITableView!
    
    
    @IBAction func resetInputValues(sender: AnyObject) {
        initialiseInputVariables()
        calculate()
    }
    
    @IBAction func displayTechnicalTips(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.aliendvr.com/support/quicktips")!)
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        numberOfCamerasLabel.text = (Int(stepper.value)).description
        calculate()
    }
    
    @IBAction func hardDiskStepperValueChanged(sender: AnyObject) {
        numberOfHardDrivesLabel.text = (Int(hardDiskStepper.value)).description
        calculate()
    }
    
    @IBAction func requestQuote(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseInputVariables()
        calculate()
    }
    
    func initialiseInputVariables() {
        for var componentIndex = 0; componentIndex < detailPicker.numberOfComponents; componentIndex++ {
            var rowIndex: Int
            
            switch componentIndex {
            case 0:
                rowIndex = 3
                resolution.value = Constants().resolutions[rowIndex].value; resolution.name = Constants().resolutions[rowIndex].name
                resolutionMultiplier = Constants().resolutionMultipliers[rowIndex]
            case 1:
                rowIndex = 6
                frameRate = Constants().frameRates[rowIndex]
                baseDataRate = Constants().baseDataRates[rowIndex]
            case 2:
                rowIndex = 0
                hardDriveCapacity.value = Constants().hardDriveCapacities[rowIndex].int; hardDriveCapacity.name = Constants().hardDriveCapacities[rowIndex].string
            default: rowIndex = 0
            }
            
            detailPicker.selectRow(rowIndex, inComponent: componentIndex, animated: true)
        }
        
        stepper.value = 4; numberOfCamerasLabel.text = (Int(stepper.value)).description
        hardDiskStepper.value = 1; numberOfHardDrivesLabel.text = (Int(hardDiskStepper.value)).description
    }
    
    func calculate() {
        let calculator = Calculator(baseDataRate: baseDataRate, resolutionMultiplier: resolutionMultiplier, numberOfCameras: stepper.value, hardDriveCapacity: hardDriveCapacity.value, numberOfHardDrives: (Int(hardDiskStepper.value)))
        
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
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return Constants().resolutions.count
        case 1:
            return Constants().frameRates.count
        case 2:
            return Constants().hardDriveCapacities.count
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
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            resolution.value = Constants().resolutions[row].value; resolution.name = Constants().resolutions[row].name
            resolutionMultiplier = Constants().resolutionMultipliers[row]
            calculate()
        case 1:
            frameRate = Constants().frameRates[row]
            baseDataRate = Constants().baseDataRates[row]
            calculate()
        case 2:
            hardDriveCapacity.value = Constants().hardDriveCapacities[row].int; hardDriveCapacity.name = Constants().hardDriveCapacities[row].string
            calculate()
        default:
           break
        }
    }
    // End UIPickerView Code
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        var quoteMessage: String = "Quote request for Alien DVR with the below specification; \n\n\(resolution.name) resolution \n\(frameRate)fps \n\(Int(stepper.value)) cameras \n\(hardDriveCapacity.name) hard drive \n\(Int(hardDiskStepper.value)) Hard Drive(s)"
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["joshua.ratcliffe@systemq.com"])
        mailComposerVC.setSubject("Alien DVR Quote Request")
        mailComposerVC.setMessageBody(quoteMessage, isHTML: false)
        mailComposerVC.navigationBar.tintColor = UIColor.whiteColor(); UIStatusBarStyle.LightContent
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}



