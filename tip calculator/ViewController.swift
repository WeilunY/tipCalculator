//
//  ViewController.swift
//  tip calculator
//
//  Created by Weilun Yao on 1/13/19.
//  Copyright © 2019 Weilun Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    // Properties:
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Storage
    let defaults = UserDefaults.standard
    var tipPercentages = [0.18, 0.2, 0.25];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator";
        billField.delegate = self;
        billField.keyboardType = .decimalPad;
        billField.becomeFirstResponder();
        

        if let x = defaults.object(forKey: "time") as? Date{
            // clear state if is longer than 5 mins
            if Date().timeIntervalSince(x) > 300.0{
                billField.text = nil;
                defaults.set(0.18, forKey: "tip0");
                defaults.set(0.20, forKey: "tip1");
                defaults.set(0.25, forKey: "tip2");
                defaults.set(0.00, forKey: "bill");
                
            } else {
                billField.text = String(format: "%.2f", defaults.double(forKey: "bill"))
                getTip();
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // load title for segment
        loadTitle();
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Store tip percentages
        for i in 0...2{
            let key = "tip\(i)";
            defaults.set(tipPercentages[i], forKey: key);
        }
        
        // Store time
        let now = Date();
        defaults.set(now, forKey: "time");
        
        // Store Bill Amount
        let bill = Double(billField.text!) ?? 0;
        defaults.set(bill, forKey: "bill");
    }
    
    // delgates
    
    // Limit input to 2 decimal points
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
    }
    

    // Behaviors
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true);
    }
    @IBAction func calculateTip(_ sender: Any) {
        getTip();
       
    }
    
    func getTip(){
        let bill = Double(billField.text!) ?? 0;
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }
    
    
    func loadTitle(){
        for i in 0 ... 2 {
            if let x = defaults.object(forKey: "tip\(i)") as? Double{
                tipPercentages[i] = x;
            }
            tipControl.setTitle(String(format: "%.0f", tipPercentages[i] * 100) + "%", forSegmentAt: i);
        }
    }
    
}

