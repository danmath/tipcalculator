//
//  ViewController.swift
//  tips
//
//  Created by Daniel Mathews on 8/9/15.
//  Copyright (c) 2015 Daniel Mathews. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var symbol:String? = "$"
    var tipPercentages = [0.18, 0.2, 0.25]
    var tipIndex = 1

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var plusSign: UILabel!
    @IBOutlet weak var equalsSign: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var chooseTipLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var totalTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadSettings()
        tipLabel.text = self.symbol! + "0.00"
        totalLabel.text = self.symbol! + "0.00"
        let defaults = NSUserDefaults.standardUserDefaults()
        if let defaultValue:NSDate = defaults.objectForKey("lastedited") as? NSDate {
            println("valued: \(defaultValue.timeIntervalSinceNow)")
            if(defaultValue.timeIntervalSinceNow > -600) {
                if let lastValue:String = defaults.objectForKey("amount") as? String {
                    self.billField.text = lastValue
                    onEditingChanged(self)
                }
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
        //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action: @selector(onSettingsButton)];
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSString(string: "\u{2699}") as String, style: UIBarButtonItemStyle.Plain, target: self, action: "toSettings")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        reloadSettings()
        onEditingChanged(self)
    }
    
    func reloadSettings() {
        //load currency type
        var oldSymbol = self.symbol
        var formatter = NSNumberFormatter()
        self.symbol = formatter.currencySymbol
        
        //load setting values
        let defaults = NSUserDefaults.standardUserDefaults()
        if let small = defaults.stringForKey("small") {
            self.tipControl.setTitle("\(small)%", forSegmentAtIndex: 0)
            self.tipPercentages[0] = (small as NSString).doubleValue/100.0
        }
        if let medium = defaults.stringForKey("medium") {
            tipControl.setTitle(medium + "%", forSegmentAtIndex: 1)
            self.tipPercentages[1] = (medium as NSString).doubleValue/100.0
        }
        if let large = defaults.stringForKey("large") {
            tipControl.setTitle(large + "%", forSegmentAtIndex: 2)
            self.tipPercentages[2] = (large as NSString).doubleValue/100.0
        }
        var index = defaults.integerForKey("tipindex")
        self.tipIndex = index
        self.tipControl.selectedSegmentIndex = index
        
        //reload calculation
    }
    
    func toSettings() {
        self.performSegueWithIdentifier("settings", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(self.tipControl.selectedSegmentIndex, forKey: "tipindex")
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        //self.symbol = formatter.currencySymbol!
        self.billField.placeholder = "\(self.symbol!)"
        if(!billField.text.isEmpty) {
            slideUp()
            var tipPercentage = self.tipPercentages[tipControl.selectedSegmentIndex]
        
            var billAmount = NSString(string: billField.text).doubleValue
            var tip = billAmount * tipPercentage
            var total = billAmount + tip
            
            tipLabel.text = self.symbol! + String(format: "%.2f", tip)
            totalLabel.text = self.symbol! + String(format: "%.2f", total)
        }
        else {
            slideDown()
            tipLabel.text = self.symbol! + "0.00"
            totalLabel.text = self.symbol! + "0.00"
        }
        defaults.setValue(billField.text, forKey: "amount")
        var date = NSDate()
        defaults.setObject(date, forKey: "lastedited")
        reloadSettings()
    }
    
    func slideUp() {
        var this = self
        UIView.animateWithDuration(0.5, animations: {
            this.billAmountLabel.frame.origin.y = 143
            this.billField.frame.origin.y = 143
            this.chooseTipLabel.frame.origin.y = 175
            this.tipControl.frame.origin.y = 195
            this.tipLabel.frame.origin.y = 247
            this.equalsSign.frame.origin.y = 276
            this.plusSign.frame.origin.y = 247
            this.totalLabel.frame.origin.y = 276
            this.tipTextLabel.frame.origin.y = 247
            this.totalTextLabel.frame.origin.y = 276
        })
    }
    
    func slideDown() {
        var this = self
        UIView.animateWithDuration(0.5, animations: {
            this.billAmountLabel.frame.origin.y = 217
            this.billField.frame.origin.y = 213
            this.chooseTipLabel.frame.origin.y = 371
            this.tipControl.frame.origin.y = 390
            this.tipLabel.frame.origin.y = 442
            this.equalsSign.frame.origin.y = 471
            this.plusSign.frame.origin.y = 442
            this.totalLabel.frame.origin.y = 471
            this.tipTextLabel.frame.origin.y = 439
            this.totalTextLabel.frame.origin.y = 476
        })
    }
}

