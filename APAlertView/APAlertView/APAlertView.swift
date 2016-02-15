//
//  APAlertView.swift
//  APAlertView
//
//  Created by ArunPrasanth R on 06/02/16.
//  Copyright © 2016 ArunPrasanth. All rights reserved.
//

import Foundation
import UIKit

struct APDefaults  {
    //Values
    static let holderWidth:CGFloat               = 300.0
    static let buttonHeight:CGFloat              = 50.0
    static let cornerRadius:CGFloat              = 6.0
    static let textFieldBorderWidth:CGFloat      = 2.0
    static let shadowOpacity:Float               = 0.15
    static let alertViewTag                      = 1991
    
    //Colors
    static let weekdayTintColor     = APColors.EmeraldColor
    static let weekendTintColor     = APColors.PomegranateColor
    static let dateSelectionColor   = APColors.PeterRiverColor
    static let monthTitleColor      = APColors.PumpkinColor
    static let todayTintColor       = APColors.AmethystColor
    static let tintColor            = APColors.PomegranateColor
    
}

struct APColors{
    static let BlueColor = UIColor(red: (0/255), green: (21/255), blue: (63/255), alpha: 1.0)
    static let YellowColor = UIColor(red: (241/255), green: (196/255), blue: (15/255), alpha: 1.0)
    static let LightGrayColor = UIColor(red: (230/255), green: (230/255), blue: (230/255), alpha: 1.0)
    static let OrangeColor = UIColor(red: (233/255), green: (159/255), blue: (94/255), alpha: 1.0)
    static let LightGreenColor = UIColor(red: (158/255), green: (206/255), blue: (77/255), alpha: 1.0)
    
    static let EmeraldColor = UIColor(red: (46/255), green: (204/255), blue: (113/255), alpha: 1.0)
    static let SunflowerColor = UIColor(red: (241/255), green: (196/255), blue: (15/255), alpha: 1.0)
    static let PumpkinColor = UIColor(red: (211/255), green: (84/255), blue: (0/255), alpha: 1.0)
    static let AsbestosColor = UIColor(red: (127/255), green: (140/255), blue: (141/255), alpha: 1.0)
    static let AmethystColor = UIColor(red: (155/255), green: (89/255), blue: (182/255), alpha: 1.0)
    static let PeterRiverColor = UIColor(red: (52/255), green: (152/255), blue: (219/255), alpha: 1.0)
    static let PomegranateColor = UIColor(red: (192/255), green: (57/255), blue: (43/255), alpha: 1.0)
}

enum APButtonOrder {
    case Horizontal     //left to right
    case Vertical       //top to bottom
}

final public class APAlertView: UIView,UITextFieldDelegate {
    
    //Private variables
    private var alertTitle:String!
    private var alertMessage:String!
    private var titleLabel          = UILabel()
    private var messageLabel        = UILabel()
    private var messageTextField    = UITextField()
    private var contentView         = UIView()
    private var alertHolderView     = UIView()
    private var shadowView          = UIView()
    private var buttons             = [APAlertButton]()
    
    //Public variables
    var alertPresent          = UIViewAnimationOptions.CurveEaseOut
    var alertDismiss          = UIViewAnimationOptions.CurveEaseOut
    var messageAlignment      = NSTextAlignment.Center          // Message alignment
    var buttonAlignment       = APButtonOrder.Horizontal        // Button order
    var placeHolderText:String?
    var titleFont: UIFont?                                      // Fonts
    var messageFont: UIFont?
    var isAlertWithTextfield:Bool?
    var currentContentHeight:CGFloat        = 10.0

    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    // Initialize with a message
    convenience public init(message: String) {
        self.init(title: "", message: message)
    }
    
    // Initialize with a title
    convenience public init(title: String) {
        self.init(title: title, message: "")
    }
    
    // Initialize with a title and a message
    public init(title: String, message: String) {
        super.init(frame: CGRectZero)
        
        alertTitle = title
        alertMessage = message
        titleLabel.text       = title
        messageLabel.text     = message
        
        self.frame            = UIScreen.mainScreen().bounds
        self.backgroundColor  = UIColor(white: 0, alpha: 0.2)
        contentView.backgroundColor = UIColor(colorLiteralRed: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)
        alertHolderView.layer.cornerRadius = APDefaults.cornerRadius
        alertHolderView.layer.masksToBounds      = true
        
        shadowView.layer.shadowColor   = UIColor.blackColor().CGColor
        shadowView.layer.shadowOffset  = CGSizeZero
        shadowView.layer.shadowOpacity = APDefaults.shadowOpacity
        shadowView.layer.shadowRadius  = APDefaults.cornerRadius
        
    }
    
    //MARK: - Add Button for Label Alertview
    public func addButtonWithTitle(title:String, action:()->Void) {
        
        let alertBtn    = APAlertButton(title: title)
        alertBtn.action = action
        alertBtn.addTarget(self, action:Selector("onClickAlertBtn:"), forControlEvents:.TouchUpInside)
        buttons.append(alertBtn)
    }
    
    public func addButtonForLabelAlert(title:String, backgroundColor: UIColor, action:()->Void) {
        
        let alertBtn    = APAlertButton(title: title, backgroundColor: backgroundColor, fontColor: nil)
        alertBtn.action = action
        alertBtn.addTarget(self, action:Selector("onClickAlertBtn:"), forControlEvents:.TouchUpInside)
        buttons.append(alertBtn)
    }
    
    public func addButtonForLabelAlert(title:String, backgroundColor: UIColor, fontColor: UIColor, action:()->Void) {
        
        let alertBtn    = APAlertButton(title: title, backgroundColor: backgroundColor, fontColor: fontColor)
        alertBtn.action = action
        alertBtn.addTarget(self, action:Selector("onClickAlertBtn:"), forControlEvents:.TouchUpInside)
        buttons.append(alertBtn)
    }
    
    //MARK: - Add Button for Textfield Alertview
    public func addButtonForTextfieldAlert(title:String, actionForTextfield:(alertText:String)->Void) {
        
        let alertBtn    = APAlertButton(title: title)
        alertBtn.actionForTextfield = actionForTextfield
        alertBtn.addTarget(self, action:Selector("onClickAlertBtn:"), forControlEvents:.TouchUpInside)
        buttons.append(alertBtn)
    }
    
    public func addButtonForTextfieldAlert(title:String, backgroundColor: UIColor, actionForTextfield:(alertText:String)->Void) {
        
        let alertBtn    = APAlertButton(title: title, backgroundColor: backgroundColor, fontColor: nil)
        alertBtn.actionForTextfield = actionForTextfield
        alertBtn.addTarget(self, action:Selector("onClickAlertBtn:"), forControlEvents:.TouchUpInside)
        buttons.append(alertBtn)
    }
    
    public func addButtonForTextfieldAlert(title:String, backgroundColor: UIColor, fontColor: UIColor,  actionForTextfield:(alertText:String)->Void) {
        
        let alertBtn    = APAlertButton(title: title, backgroundColor: backgroundColor, fontColor: fontColor)
        alertBtn.actionForTextfield = actionForTextfield
        alertBtn.addTarget(self, action:Selector("onClickAlertBtn:"), forControlEvents:.TouchUpInside)
        buttons.append(alertBtn)
    }

    //MARK:- Set Frame
    private func setFrames() {
        for subview in self.subviews {
            if subview == alertHolderView {
                subview.removeFromSuperview()
            }
        }
        
        self.frame = UIScreen.mainScreen().bounds
        
        // Title Label
        if titleLabel.text?.characters.count > 0 {
            
            currentContentHeight = 21.0
            titleLabel.frame = CGRect(x: 22, y: currentContentHeight, width: APDefaults.holderWidth-44, height: 25)
            currentContentHeight = getBottomPosition(titleLabel)
            titleLabel.textAlignment = NSTextAlignment.Center
            titleLabel.font = (titleFont != nil) ? titleFont : UIFont.boldSystemFontOfSize(16)
            alertHolderView.addSubview(titleLabel)
        }
        
        //Message Label
        if isAlertWithTextfield == false {
            messageLabel.numberOfLines = 0
            let messageSize    = messageLabel.sizeThatFits(CGSizeMake(300, 20))
            var lblHeight = messageSize.height
            if lblHeight >= self.frame.size.height-200 {
                lblHeight = self.frame.size.height-200
            }
            messageLabel.frame = CGRect(x: 22, y: currentContentHeight + 10, width: APDefaults.holderWidth-44, height: lblHeight)
            currentContentHeight = getBottomPosition(messageLabel)
        } else {
            messageTextField.frame = CGRect(x: 22, y: currentContentHeight + 10, width: APDefaults.holderWidth-44, height: 31.0)
            currentContentHeight = getBottomPosition(messageTextField)
        }
        
        //Button Frame
        let space:CGFloat = 1.0
        let width  = (APDefaults.holderWidth - space * CGFloat(buttons.count-1)) / CGFloat(buttons.count)
        
        for i in 0..<buttons.count {
            let btn   = buttons[i]
            
            if buttonAlignment == APButtonOrder.Horizontal {
                
                btn.frame  = CGRect(x: (width + space)*CGFloat(i), y: currentContentHeight + 15, width: width, height: APDefaults.buttonHeight)
                
                if i == buttons.count - 1 {
                    currentContentHeight = getBottomPosition(btn)
                }
            } else {
                
                let y = (i == 0) ? currentContentHeight + 15: currentContentHeight + space
                btn.frame = CGRect(x: 0.0, y: y, width: APDefaults.holderWidth, height: APDefaults.buttonHeight)
                currentContentHeight = getBottomPosition(btn)
            }
            
            alertHolderView.addSubview(btn)
        }
        
        //Shadowview & Content view Frames
        shadowView.frame     = CGRect(x: 0, y: 0, width: APDefaults.holderWidth, height: currentContentHeight)
        shadowView.center    = self.center
        alertHolderView.frame  = CGRect(origin: CGPointZero, size: shadowView.frame.size)
        
        contentView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        
    }
    
    //MARK:- Show Alertview
    public func showAlert(isTextfieldAlert:Bool) {
        
        isAlertWithTextfield = isTextfieldAlert
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        // Add self to keyWindow
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
            if keyWindow.viewWithTag(APDefaults.alertViewTag) == nil {
                self.tag = APDefaults.alertViewTag
                keyWindow.addSubview(self)
            }
        } else {
            return
        }
        
        // Notification for rotation
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        // Init tapgesture
        initTapGesture()
        
        // Init Frame
        setFrames()
        
        // Add Message Label
        if isTextfieldAlert == true {
            messageTextField.textAlignment = messageAlignment
            messageTextField.font = (messageFont != nil) ? messageFont : UIFont.systemFontOfSize(16)
            alertHolderView.backgroundColor = UIColor.whiteColor()
            alertHolderView.addSubview(messageTextField)
            messageTextField.layer.borderWidth = APDefaults.textFieldBorderWidth
            messageTextField.layer.borderColor = APColors.AsbestosColor.CGColor
            messageTextField.layer.cornerRadius = APDefaults.cornerRadius
            messageTextField.delegate = self
            messageTextField.placeholder = (placeHolderText != nil) ? placeHolderText : ""

        } else {
            messageLabel.textAlignment = messageAlignment
            messageLabel.font = (messageFont != nil) ? messageFont : UIFont.systemFontOfSize(16)
            alertHolderView.backgroundColor = UIColor.whiteColor()
            alertHolderView.addSubview(messageLabel)
        }
        
        
        // Add Shadow View & AlertHolder View & Contentview
        shadowView.addSubview(alertHolderView)
        contentView.addSubview(shadowView)
        self.addSubview(contentView)
        
        // Add animation Fade-in
        self.alpha     = 0.0
        self.transform = CGAffineTransformMakeScale(1.3, 1.3)
        
        UIView.animateWithDuration(0.2,
            delay: 0.0,
            options: alertPresent,
            animations: {
                self.transform = CGAffineTransformMakeScale(1.0, 1.0)
                self.alpha = 1.0
            },
            completion: {(finished) in
            }
        )

    }
    
    //MARK:- UIButton Action
    func onClickAlertBtn(btn:APAlertButton) {
        if isAlertWithTextfield == true {
            btn.actionForTextfield(alertText: messageTextField.text!)
        } else {
            btn.action()
        }
        dismiss()
    }

    //MARK:-  Dismiss Alertview
    func dismiss() {
        
        // Apply a fade-out animation
        UIView.animateWithDuration(0.18,
            delay: 0.0,
            options: alertDismiss,
            animations: {
                self.alertHolderView.transform = CGAffineTransformMakeScale(0.8, 0.8)
                self.alpha = 0.0
            },
            completion: {(finished) in
                self.removeFromSuperview()
                self.contentView.removeFromSuperview()
                
            }
        )
    }

    //MARK:- UITextfield Delegate
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    private func initTapGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismiss")
        contentView.addGestureRecognizer(tap)
        messageTextField.removeGestureRecognizer(tap)
    }
    
    func rotated() {
        setFrames()
    }
    
    private func getBottomPosition(view: UIView) -> CGFloat {
        return view.frame.origin.y + view.frame.height
    }
}

internal final class APAlertButton: UIButton {
    private var target:AnyObject!
    private var action:(()->Void)!
    private var actionForTextfield:((alertText:String)->Void)!

    override var highlighted: Bool {
        didSet {
            
            self.alpha = (highlighted) ? 0.8 : 1.0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(title: title, backgroundColor: nil, fontColor: nil)
    }
    
    init(title: String, backgroundColor: UIColor?, fontColor: UIColor?) {
        super.init(frame: CGRectZero)
        self.backgroundColor = (backgroundColor != nil) ? backgroundColor! : self.tintColor
        self.setTitle(title, forState: .Normal)
        self.setTitleColor((fontColor != nil) ? fontColor! : UIColor.whiteColor() , forState: .Normal)
    }
}