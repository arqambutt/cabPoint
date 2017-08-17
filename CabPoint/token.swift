//
//  token.swift
//  CabPoint
//
//  Created by abdur rehman on 8/9/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//


import Foundation
import UIKit
import FirebaseMessaging
import Firebase

typealias Results = (_ msg:String)-> Void

class SendFcmToken {
    
    
    
    static var object  = SendFcmToken()
    
    
    
    func SendFcmTokenFun(token:String , results:@escaping Results){
       
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "d9029f2a-02fd-91a9-cfb9-4d8cfaff9546"
        ]
        
        
        let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\","+"\"device_token\""+":"+"\"\(token)\""+"}"
     
        let data = postData.data(using: .utf8)
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/devicetoken")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
            
            } else {
                
                do {
                    
                    
                    
                    let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                    
                   
                    let errorcode = temp["status"]  as! NSObject
                    
                    if(String(describing: errorcode) == "0"){
                        
                        let error = temp["error_msg"] as! NSObject
                        
                        return results(error as! String)
                        
                    }else{
                        
                        DispatchQueue.main.async {
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            return results("")
                        }
                        
                    }
                    
                    
                }catch{
                    
                }
            }
          
        })
        
        dataTask.resume()
        
        
    }

}

