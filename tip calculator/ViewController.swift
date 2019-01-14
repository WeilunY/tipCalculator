//
//  ViewController.swift
//  tip calculator
//
//  Created by Weilun Yao on 1/13/19.
//  Copyright © 2019 Weilun Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // load title for segment
        for i in 0 ... 2 {
            if let x = defaults.object(forKey: "tip\(i)") as? Double{
                tipPercentages[i] = x;
            }
            tipControl.setTitle(String(format: "%.0f", tipPercentages[i] * 100) + "%", forSegmentAt: i);
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Store tip percentages
        for i in 0...2{
            let key = "tip\(i)";
            defaults.set(tipPercentages[i], forKey: key);
        }
    }
    

    // Behaviors
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true);
    }
    @IBAction func calculateTip(_ sender: Any) {
    
        let bill = Double(billField.text!) ?? 0;
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }
    
    
}

