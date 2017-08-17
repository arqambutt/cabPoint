//
//  addPromo.swift
//  CabPoint
//
//  Created by abdur rehman on 8/5/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import UIKit

class addPromo: UIViewController {

    
    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var addpromolabel: UILabel!
    @IBOutlet weak var textfieldCode: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity.isHidden = true
        
        viewHelper.instance.bottom_Line(views: textfieldCode)
        
    }

    
    
    
    
    @IBAction func Verify(_ sender: Any) {
        
        
        addpromolabel.text = "Verifying Promo.."
        activity.isHidden = false
        activity.startAnimating()
        
        
        PromoOffer.object.findPromotion(promoCode: "\(String(describing: textfieldCode.text!))") { (result) in
            
            if (result == "" ){
                
                self.addpromolabel.text = "Add Promo code "
                self.activity.stopAnimating()
                self.activity.isHidden = true
               
                 self.performAlert(msg: "Promo Code is added in you account")
                
                
            }else{
                
                self.addpromolabel.text = "Add Promo code "
                self.activity.stopAnimating()
                self.activity.isHidden = true
                self.performAlert(msg: "No Promo Code Found by this name")
            }
        }
        
        
        
        
        
    }
    
    func performAlert(msg:String){
        
        let alert  = UIAlertController(title: "Alert", message: "\(msg)", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return UIStatusBarStyle.lightContent
    }
 

}
