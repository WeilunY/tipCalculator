//
//  SettingsViewController.swift
//  tip calculator
//
//  Created by Weilun Yao on 1/13/19.
//  Copyright © 2019 Weilun Yao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    
    @IBOutlet weak var tipLabel1: UILabel!
    @IBOutlet weak var tipLabel2: UILabel!
    @IBOutlet weak var tipLabel3: UILabel!
    
    @IBOutlet weak var tipSlider1: UISlider!
    @IBOutlet weak var tipSlider2: UISlider!
    @IBOutlet weak var tipSlider3: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load values
        let tip0 = defaults.double(forKey: "tip0") * 100;
        tipLabel1.text = String(format: "%.0f", tip0) + "%";
        tipSlider1.value = Float(tip0);
        
        let tip1 = defaults.double(forKey: "tip1") * 100;
        tipLabel2.text = String(format: "%.0f", tip1) + "%";
        tipSlider2.value = Float(tip1);
        
        let tip2 = defaults.double(forKey: "tip2") * 100;
        tipLabel3.text = String(format: "%.0f", tip2) + "%";
        tipSlider3.value = Float(tip2);
    }
    
    
    @IBAction func change1(_ sender: Any) {
        let value = Int(tipSlider1.value);
        tipLabel1.text = "\(value)%";
        defaults.set(Double(value) / 100, forKey: "tip0");
        
    }
    
    @IBAction func change2(_ sender: Any) {
        let value = Int(tipSlider2.value);
        tipLabel2.text = "\(value)%";
        defaults.set(Double(value) / 100, forKey: "tip1");
        
    }
    
    @IBAction func change3(_ sender: Any) {
        let value = Int(tipSlider3.value);
        tipLabel3.text = "\(value)%";
        defaults.set(Double(value) / 100, forKey: "tip2");
    }
    
    @IBAction func reset(_ sender: Any) {
        tipLabel1.text = "18%";
        tipLabel2.text = "20%";
        tipLabel3.text = "25%";
        
        tipSlider1.value = 18;
        tipSlider2.value = 20;
        tipSlider3.value = 25;
        
        defaults.set(0.18, forKey: "tip0");
        defaults.set(0.20, forKey: "tip1");
        defaults.set(0.25, forKey: "tip2");
        
        
    }
}
