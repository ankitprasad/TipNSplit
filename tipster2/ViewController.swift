//
//  ViewController.swift
//  tipster2
//

import UIKit

extension UIView {
    func fade(duration: NSTimeInterval = 0.5, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
}

class ViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var billAmountButton: UIButton!
    
    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipPercentButton: UIButton!
    
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var tipAmountStaticLabel: UILabel!
    
    @IBOutlet weak var totalAmountStaticLabel: UILabel!
    
    @IBOutlet weak var tipPickerView: UIPickerView!
    
    @IBOutlet weak var tipPercentStaticLabel: UILabel!
    
    @IBOutlet weak var billAmountBoxView: UIView!
    
    @IBOutlet weak var tipPercentBoxView: UIView!
    
    @IBOutlet weak var box1View: UIView!
    
    @IBOutlet weak var box2View: UIView!
    
    @IBOutlet weak var box3View: UIView!
    
    
    @IBOutlet weak var userGroupImage: UIImageView!
    @IBOutlet weak var numberOfPeopleSegment: UISegmentedControl!
    
    @IBOutlet weak var youPayAmountLabel: UILabel!

    var percentArrayString = ["10%", "15%", "18%", "20%", "25%"]
    var numberOfPeopleArray : [Double] = [1, 2, 3, 4, 5, 6]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var billPlaceholder = NSAttributedString(string: "$", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        billField.attributedPlaceholder = billPlaceholder
        
        tipPickerView.alpha = 0
        
        billField.becomeFirstResponder()
        
    }


    @IBAction func tapBillAmountButton(sender: AnyObject) {
        billField.becomeFirstResponder()
    }
    
    @IBAction func billAmountChanged(sender: AnyObject) {
        calculateTipAndTotal(nil)
    }
    
    
    @IBAction func billAmountEditingBegin(sender: AnyObject) {
        //show self
        billField.alpha = 1
        
        //hide tip button, tip amount and total
        tipPercentStaticLabel.alpha = 0
        box1View.alpha = 0
        box2View.alpha = 0
     
        billAmountBoxView.alpha = 0
        tipPercentBoxView.alpha=0
        
        box3View.alpha = 0
        numberOfPeopleSegment.alpha=0
        userGroupImage.alpha=0
        
    }
    
    
    @IBAction func billAmountEditingEnd(sender: AnyObject) {
        
        // populate Bill Button
        var billFieldDouble = (billField.text as NSString).doubleValue
        var billAmountButtonText = NSString(format: "$%.2f", billFieldDouble) as String
        billAmountButton.setTitle(billAmountButtonText, forState: UIControlState.Normal)
        
    }
    
    @IBAction func numberOfPeopleSegmentChanged(sender: AnyObject) {
        calculateTipAndTotal(nil)
    }
    
    func calculateTipAndTotal(tipString :String?) {
        
        var billAmount = (billField.text as NSString).doubleValue
        
        var tipPercentString : String
        if (tipString == nil) {
            tipPercentString = tipPercentButton.titleLabel!.text!

        } else {
            tipPercentString = tipString!
        }
        
        let range = advance(tipPercentString.endIndex, -1)
        tipPercentString = tipPercentString.substringToIndex(range)
        var tipNumber = (tipPercentString as NSString).doubleValue
        var tipAmount = tipNumber/100 * billAmount
        tipAmountLabel.text = NSString(format: "$%.2f",tipAmount) as String
        var totalAmount = billAmount + tipAmount
        totalAmountLabel.text = NSString(format: "$%.2f",totalAmount) as String
        
        var youPayAmount = totalAmount/numberOfPeopleArray[numberOfPeopleSegment.selectedSegmentIndex]
        youPayAmountLabel.text = NSString(format: "$%.2f",youPayAmount) as String
        
    }

    @IBAction func tapTipAmountButton(sender: UIButton) {
        view.endEditing(true)
        tipPickerView.fade(duration:0.25)
        
        //hide bill splitter
        box3View.alpha = 0
        numberOfPeopleSegment.alpha=0
        userGroupImage.alpha=0
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        tipPickerView.alpha = 0
        
        //show tip percent button
        tipPercentStaticLabel.fade(duration:0.25)
        
        // show tip amount and total values
        box1View.fade(duration:0.25)
        box2View.fade(duration:0.25)
        box3View.fade(duration:0.25)
        billAmountBoxView.fade(duration:0.25)
        tipPercentBoxView.fade(duration:0.25)
        numberOfPeopleSegment.fade(duration:0.25)
        userGroupImage.fade(duration:0.25)
        
        
        // hide billfield
        billField.alpha=0
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return percentArrayString.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return percentArrayString[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipPercentButton.setTitle(percentArrayString[row], forState: UIControlState.Normal)

        calculateTipAndTotal(percentArrayString[row])
        

    }
    
}

