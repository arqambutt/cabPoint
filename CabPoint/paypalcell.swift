//
//  paypalcell.swift
//  CabPoint
//
//  Created by abdur rehman on 8/10/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import UIKit

class paypalcell: UITableViewCell {
    
    @IBOutlet weak var digit: UILabel!
    
    @IBOutlet weak var defaultSelection: UIImageView!
    
    var defaultCard = ""
    var defaultCardNumber = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         defaultSelection.isHidden = true
      
        
       

    }
    
    func config(object:paypalModal){
        
         defaultSelection.isHidden = true
        let result = UserDefaults.standard.value(forKey: "cardName")
        let cardNumber = UserDefaults.standard.value(forKey: "cardNumber")
        
        if(result != nil){
            
            
            
            if(String(describing: result!) != "" ){
                
                defaultCard = String(describing: result!)
                
            }
            if(String(describing: cardNumber!) != "" ){
                
                defaultCardNumber = String(describing: cardNumber!)
                
            }
        }
        print(defaultCard)
        print(defaultCardNumber)
        
        if(defaultCard == "PP"){
            
            
            if(object.paypal_id == defaultCardNumber){
                
                defaultSelection.isHidden = false
                digit.text = "\(object.email)"
                
                
            }
            
        }
        
        
        digit.text = "\(object.email)"
        
        
        
        
    }
    
    
}
