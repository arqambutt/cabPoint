//
//  driverRating.swift
//  CabPoint
//
//  Created by abdur rehman on 8/16/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import Foundation

typealias driverRating  = (_ nsg:String) -> Void


class DriverRATING {
    
    
    static var object = DriverRATING()
    
    
    func RateDriver(jobid:String , comment:String , rating:String , result:@escaping driverRating){
        
        
      
        
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
                "postman-token": "2503c05e-4f81-30c5-50be-04bdb9a33625"
            ]
            
            
            
        let postData = "data={"+"\"job_id\""+":"+"\"\(jobid)\""+","+"\"userid\""+":"+"\"\(userDetail.object.userid)\""+","+"\"rating\""+":"+"\"\(rating)\","+"\"comment\""+":"+"\"\(comment)\"}"
        
        
        
            let data = postData.data(using: .utf8)
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/rateadriver")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                if (error != nil) {
                    
                } else {
                    
                    DispatchQueue.main.async {
                        
                        
                        do {
                            
                            let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                            
                            let data = temp as NSDictionary
                            
                            let cheak = data.value(forKey: "status")!
                            
                            let cheakNow = String(describing: cheak)
                            
                            if (cheakNow == "0"){
                                
                                return result("\(String(describing: data.value(forKey: "error_msg")!))")
                            }else {
                                
                                
                                
                              
                                DispatchQueue.main.async {
                                    
                                   
                                    return result("")
                                    
                                
                                }
                                
                            }
                            
                        }catch{
                            print(error)
                        }
                    }
                    
                    
                }
                
            })
        
            dataTask.resume()
        }
    
    
    

    
}
