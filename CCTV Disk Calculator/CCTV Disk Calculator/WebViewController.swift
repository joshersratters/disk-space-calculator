//
//  WebViewController.swift
//  CCTV Disk Calculator
//
//  Created by Joshua Ratcliffe on 23/04/2015.
//  Copyright (c) 2015 Joshua Ratcliffe. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var viewWeb: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://m.aliendvr.com/support")
        var request = NSURLRequest(URL: url!)
        viewWeb.loadRequest(request)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
