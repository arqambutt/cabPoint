//
//  RefershState.swift
//  CabPoint
//
//  Created by abdur rehman on 8/15/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import Foundation


class refresh {
    
    
    static var object  = refresh()
    
    
    
    func refreshFunction(){
        DispatchQueue.global(qos: .background).async {
            let headers = [
                "content-type": "application/x-www-form-urlencoded",
                "cache-control": "no-cache",
                "postman-token": "2503c05e-4f81-30c5-50be-04bdb9a33625"
            ]
            
            print(userDetail.object.userid)
        
            
            let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\""+"}"
            
            let data = postData.data(using: .utf8)
            
            let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/initializestate")! as URL,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
            
            })
            
            dataTask.resume()
        }
        

        
    }

}
