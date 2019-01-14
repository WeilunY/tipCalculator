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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Behaviors
    @IBAction func onTap(_ sender: Any) {
        
        view.endEditing(true);
    }
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.18, 0.2, 0.25];
        
        let bill = Double(billField.text!) ?? 0;
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex];
        let total = bill + tip;
        tipLabel.text = String(format: "$%.2f", tip);
        totalLabel.text = String(format: "$%.2f", total);
    }
    
}

