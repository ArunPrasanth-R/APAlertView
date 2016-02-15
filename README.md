
# APAlertView
APAlertView component for iOS written in Swift

Preview
-------
![Screenshot](https://raw.githubusercontent.com/ArunPrasanth-R/APAlertView/master/APAlertView/Resources/ScreenShot_1.png)    ![Screenshot](https://raw.githubusercontent.com/ArunPrasanth-R/APAlertView/master/APAlertView/Resources/ScreenShot_2.png) ![Screenshot](https://raw.githubusercontent.com/ArunPrasanth-R/APAlertView/master/APAlertView/Resources/ScreenShot_3.png)


Installation
------------
# Manual Installation

Just drag and drop the `APAlertView` folder into your project


Features
--------

APAlertView provides lot of features which lets you customize the alertview

1. AlertView with horizontal and vertical button option
2. AlertView with textfield
3. AlertView with label
4. Action blocks that return the selected buttons

Initialization
--------------
You can init the alertview as follows

        let alertViewLabel = APAlertView(title: "AP",message: "Hope you like this component!!")
        alertViewLabel.messageAlignment = NSTextAlignment.Center
        alertViewLabel.addButtonForLabelAlert("YES", backgroundColor: UIColor(colorLiteralRed: 76.0/255.0, green: 182.0/255.0, blue: 73.0/255.0, alpha: 1)) { () -> Void in
        print("Selected Yes")
        }        
        alertViewLabel.showAlert(false)

License
-------
None

Contributors
------------
[@ArunPrasanth-R](https://github.com/ArunPrasanth-R)


