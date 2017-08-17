//
//  FreerIDE.swift
//  Cabigate
//
//  Created by abdur rehman on 7/17/17.
//  Copyright © 2017 abdur rehman. All rights reserved.
//

import Foundation
import UIKit


typealias offer = (_ msg:String)-> Void
class PromoOffer {
    
    
    static var object  = PromoOffer()
  
 
    
    func findPromotion(promoCode:String, result:@escaping offer){
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "ec5e5d86-7224-4893-7e89-2ef354e40258"
        ]
        
        
        
        let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\","+"\"promocode\""+":"+"\"\(promoCode)\""+"}"
        
        let data = postData.data(using: .utf8)
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/promocodevalidate")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                
                do {
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                    print(temp)
                    
                    DispatchQueue.main.async {
                        
                        
                        let errorcode = temp["status"]  as! NSObject
                        
                        if(String(describing: errorcode) == "0"){
                            
                             UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            
                            let error = temp["error_msg"] as! NSObject
                            
                            return result(error as! String)
                            
                        }else{
                            
                           
                            
                             print(temp["response"] as! NSDictionary)
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            return result("")
                        }
                        
                    }
                    
                    
                }catch{
                     UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    print(error)
                }
            }
        })
        
        dataTask.resume()
        
        
    }
    
}

