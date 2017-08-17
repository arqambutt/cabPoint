//
//  cash.swift
//  CabPoint
//
//  Created by abdur rehman on 8/3/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import UIKit

class cash: UIViewController {

    @IBOutlet weak var referanceOpertor: UIButton!
    
    
    @IBAction func setDefault(_ sender: Any) {
        
        
        UserDefaults.standard.set("Cash", forKey: "cardName")
        UserDefaults.standard.set("", forKey: "cardNumber")
    
        
    }
    
}
