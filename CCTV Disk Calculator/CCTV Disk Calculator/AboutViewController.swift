//
//  AboutViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 08/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBAction func alienLogoPress(sender: UITapGestureRecognizer) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.aliendvr.com")!)
    }
    
    @IBAction func niteDevilLogoPress(sender: UITapGestureRecognizer) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.nitedevil.com")!)
    }
    
    @IBAction func closeModal(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func feedbackButtonPress(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["joshua.ratcliffe@systemq.com"])
        mailComposerVC.setSubject("Alien Calculator Feedback")
        mailComposerVC.setMessageBody("I would like to share the following feedback", isHTML: false)
        
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
    


    
    
     func viewDidLoad() {
        viewDidLoad()

        // Do any additional setup after loading the view.
    }

     func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        //var secondScene = segue.destinationViewController as ViewController
        // Pass the selected object to the new view controller.
    //}
    


