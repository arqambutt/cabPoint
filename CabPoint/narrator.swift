//
//  narrator.swift
//  CabPoint
//
//  Created by abdur rehman on 8/11/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import Foundation


typealias narr = (_ msg:String)-> Void




class narrator{
    
    
    
    
    
    static var instance  = narrator()


    func send(result:narr) {
        
       var sttring = ""
        
        var Sson:[[String:Any]] = []
        Sson.append( ["item1":"newItemOne" , "status":"0"])
        Sson.append( ["item1":"newItemOne" , "status":"0"])
        
        
        do {
            let jsoData = try JSONSerialization.data(withJSONObject: Sson, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            //print(jsoData)
            
            //Do this for print data only otherwise skip
            if let JSONString = String(data: jsoData, encoding: String.Encoding.utf8) {
                sttring = JSONString
                print(JSONString)
            }
        }catch {
            
        }
        
        
        
        let json:[String:Any] = ["listid" : "", "save" : "1", "uid" : "20", "list_name" : "hello6", "list_item" : Sson]

        
        do {
            
            //Convert to Data
            let jsoData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            if let JSONString = String(data: jsoData, encoding: String.Encoding.utf8) {
                
                
                
                print("data\(JSONString)")
                
                
                
                let headers = [
                    "content-type": "application/x-www-form-urlencoded",
                    "cache-control": "no-cache",
                    "postman-token": "4bd67ebc-3c2c-441b-8424-483c5ad305b1"
                ]
                
                
                
                let postData = "data=\(JSONString)"
                
                
                if let data = postData.data(using: .utf8) {
                    
                    print(data)
                
                
                print(data)
                
                let request = NSMutableURLRequest(url: NSURL(string: "http://128.199.199.239:3002/saveuserlist")! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                request.httpBody = data as Data
                
                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    
                  
                    
                    if (error != nil) {
                        print(error!)
                    } else {
                        
                        print(data!)
                        
                        do {
                            
                            let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            
                            print(temp)
                            
                        }catch{
                            print(error)
                        }
                    }
                })
                
                dataTask.resume()
                
                }
                
            }
            
            
       
         
        } catch {
            // print(error.description)
        }
        
        
        //print(json)
     
        
        
        
}

}
