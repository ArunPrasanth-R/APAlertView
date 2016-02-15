 //
//  ViewController.swift
//  APAlertView
//
//  Created by ArunPrasanth R on 06/02/16.
//  Copyright © 2016 ArunPrasanth. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
    }
    
    @IBAction func alertStyle1(sender: AnyObject) {
//        let alertView = APAlertView(title: "AP AlertView", message: "Do you like this component")
        let alertViewLabel = APAlertView(title: "AP",message: "Hope you like this component!!")
        
        alertViewLabel.messageAlignment = NSTextAlignment.Center
        alertViewLabel.buttonAlignment  = APButtonOrder.Horizontal
        alertViewLabel.alertPresent = UIViewAnimationOptions.TransitionCrossDissolve
        
        alertViewLabel.addButtonForLabelAlert("YES", backgroundColor: UIColor(colorLiteralRed: 76.0/255.0, green: 182.0/255.0, blue: 73.0/255.0, alpha: 1)) { () -> Void in
            print("Selected Yes")
        }
        
        alertViewLabel.addButtonForLabelAlert("NO", backgroundColor: UIColor(colorLiteralRed: 76.0/255.0, green: 182.0/255.0, blue: 73.0/255.0, alpha: 1)) { () -> Void in
            print("Selected No")
        }
        
        // Show Alert
        alertViewLabel.showAlert(false)
    }
    
    @IBAction func alertStyle2(sender: AnyObject) {
        let alertView = APAlertView(title: "Lorem Ipsum", message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.")
        
        alertView.messageAlignment = NSTextAlignment.Center
        alertView.buttonAlignment  = APButtonOrder.Vertical
        
        alertView.addButtonForLabelAlert("Remind me later", backgroundColor: UIColor(colorLiteralRed: 232.0/255.0, green: 82.0/255.0, blue: 81.0/255.0, alpha: 1), fontColor: UIColor.whiteColor()) { () -> Void in
            print("Remind me later")

        }
        
        alertView.addButtonForLabelAlert("Remind me after 1 hour", backgroundColor: UIColor(colorLiteralRed: 232.0/255.0, green: 82.0/255.0, blue: 81.0/255.0, alpha: 1), fontColor: UIColor.whiteColor()) { () -> Void in
            print("Remind me after 1 hour")
            
        }
        
        alertView.addButtonForLabelAlert("Remind me tomorrow", backgroundColor: UIColor(colorLiteralRed: 232.0/255.0, green: 82.0/255.0, blue: 81.0/255.0, alpha: 1), fontColor: UIColor.whiteColor()) { () -> Void in
            print("Remind me tomorrow")
            
        }
        
        // Show Alert
        alertView.showAlert(false)
    }
    
    @IBAction func alertTextfield(sender: AnyObject) {
        let alertView = APAlertView(title: "Enter your name")
        
        alertView.messageAlignment = NSTextAlignment.Center
        alertView.buttonAlignment  = APButtonOrder.Horizontal
        alertView.placeHolderText = "Name"
        
        alertView.addButtonForTextfieldAlert("Discard", backgroundColor: UIColor(colorLiteralRed: 232.0/255.0, green: 82.0/255.0, blue: 81.0/255.0, alpha: 1), fontColor: UIColor.whiteColor())  { (alertText) -> Void in
            print(alertText)
        }
        
        alertView.addButtonForTextfieldAlert("Save", backgroundColor: UIColor(colorLiteralRed: 232.0/255.0, green: 82.0/255.0, blue: 81.0/255.0, alpha: 1), fontColor: UIColor.whiteColor())  { (alertText) -> Void in
            print(alertText)
        }
        
        // Show Alert
        alertView.showAlert(true)
    }
}

