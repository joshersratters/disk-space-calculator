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
    
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerViewController = MFMailComposeViewController()
        mailComposerViewController.mailComposeDelegate = self
        
        mailComposerViewController.setToRecipients(["joshratcliffe@me.com"])
        mailComposerViewController.setSubject("App Feedback")
        mailComposerViewController.setMessageBody("I would like to share the following feedback", isHTML: false)
        
        return mailComposerViewController
    }
    
    var mailComposeDelegate : MFMailComposeViewControllerDelegate!
    
    @IBAction func closeModal(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func feedbackButtonPress(sender: AnyObject) {
        
         let mailComposer : MFMailComposeViewController = configureMailComposeViewController()
        
        //Check to see the device can send email.
        //http://kellyegan.net/sending-files-using-swift/
        if MFMailComposeViewController.canSendMail() {
            
           
            mailComposer.mailComposeDelegate = self
            
            
            //Open composition window
            self.presentViewController(mailComposer, animated: true, completion: nil)
            
        }   else {
            //cannot send email
            println("This device cannot send email")
        }
        
        
        //Check to see what the user did with the composition window
        func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
            
            switch result.value {
                
            case MFMailComposeResultSent.value:
                println("You sent the email.")
        
            case MFMailComposeResultSaved.value:
                println("You saved a draft of this email.")
                
            case MFMailComposeResultCancelled.value:
                println("You cancelled sending this email.")
                
            case MFMailComposeResultFailed.value:
                println("Mail failed:  An error occurred when trying to compose this email")
            
            default:
                break
            }
        
        self.dismissViewControllerAnimated(true, completion: nil)
            
        }
}
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        //var secondScene = segue.destinationViewController as ViewController
        // Pass the selected object to the new view controller.
    //}
    

}
