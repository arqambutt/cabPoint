//
//  paypalAccoun.swift
//  CabPoint
//
//  Created by abdur rehman on 8/10/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import Foundation

typealias addPaypal = (_ msg:String)-> Void
typealias listPaypal = (_ msg:String)-> Void
typealias DefaultPaypal = (_ msg:String)-> Void
typealias Remove = (_ msg:String)-> Void


class paypalMianIntegration {
    
    
    
    static var object = paypalMianIntegration()
    
    
    
        static var paypalModalArray = [paypalModal]()
        

    func AddPaypalCard(mainPaypalCode:String , MetaId:String, result:@escaping addPaypal){
        
        
        print(mainPaypalCode)
        
        
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "ddb48935-d86a-eee2-6232-f68b6123dd7e"
        ]
        let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\","+"\"code\""+":"+"\"\(mainPaypalCode)\""+","+"\"client_metadata_id\""+":"+"\"\(MetaId)\"}"
        
        let data = postData.data(using: .utf8)
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/paypalauthorizationcode")! as URL,
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
                
                DispatchQueue.main.async {
                    
                    
                    do {
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        print(temp)
                        let data = temp as NSDictionary
                        
                        let cheak = data.value(forKey: "status")!
                        
                        let cheakNow = String(describing: cheak)
                        
                        if (cheakNow == "0"){
                            
                            return result("\(String(describing: data.value(forKey: "error_msg")!))")
                            
                        }else {
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            return result("")
                            
                        }
                        
                        
                        
                    }catch{
                        print(error)
                    }
                }
                
                
            }
            
            
            
            
        })
        
        dataTask.resume()
        
        
        
    }
    
    
    func SeeALLPaypalCard(result:@escaping listPaypal) {
        
        paypalMianIntegration.paypalModalArray.removeAll()
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "ddb48935-d86a-eee2-6232-f68b6123dd7e"
        ]
        let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\"}"
        
        let data = postData.data(using: .utf8)
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/paypalaccountlist")! as URL,
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
                
                DispatchQueue.main.async {
                    
                    
                    do {
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                         print(temp)
                        
                        
                        let data = temp as NSDictionary
                        
                        let cheak = data.value(forKey: "status")!
                        
                        let cheakNow = String(describing: cheak)
                        
                        if (cheakNow == "0"){
                            
                            return result("\(String(describing: data.value(forKey: "error_msg")!))")
                            
                        }else {
                            
                            print(temp)
                            
                            let data = temp["response"] as! NSDictionary
                            
                            let array  = data["list"] as! NSArray
                            
                            DispatchQueue.main.async {
                                
                                for i in array  {
                                    
                                    
                         paypalMianIntegration.paypalModalArray.append(paypalModal.init(data: i as! NSDictionary))
    
                                }
                                
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                
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
    
    
    
    
    func paypalDefaultCard(id:String ,  result:@escaping DefaultPaypal) {
        
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "ddb48935-d86a-eee2-6232-f68b6123dd7e"
        ]
       let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\","+"\"paypal_id\""+":"+"\"\(id)\""+"}"
        
        let data = postData.data(using: .utf8)
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/makedefaultpaypal")! as URL,
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
                
                DispatchQueue.main.async {
                    
                    
                    do {
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                        print(temp)
                        let data = temp as NSDictionary
                        
                        let cheak = data.value(forKey: "status")!
                        
                        let cheakNow = String(describing: cheak)
                        
                        if (cheakNow == "0"){
                            
                            return result("\(String(describing: data.value(forKey: "error_msg")!))")
                            
                        }else {
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            return result("")
                            
                        }
                        
                        
                        
                    }catch{
                        print(error)
                    }
                }
                
                
            }
            
            
            
            
        })
        
        dataTask.resume()
        

        
    }
    
    
     func RemovePaypal(id:String ,  result:@escaping Remove) {
        

        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache",
            "postman-token": "ddb48935-d86a-eee2-6232-f68b6123dd7e"
        ]
        let postData = "data={"+"\"passenger_id\""+":"+"\"\(userDetail.object.userid)\","+"\"paypal_id\""+":"+"\"\(id)\""+"}"
        
        let data = postData.data(using: .utf8)
        let request = NSMutableURLRequest(url: NSURL(string: "http://paxapi.cabigate.com/index.php/deletepaypalaccount")! as URL,
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
                
                DispatchQueue.main.async {
                    
                    
                    do {
                        
                        let temp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
                        
                        print(temp)
                        let data = temp as NSDictionary
                        
                        let cheak = data.value(forKey: "status")!
                        
                        let cheakNow = String(describing: cheak)
                        
                        if (cheakNow == "0"){
                            
                            return result("\(String(describing: data.value(forKey: "error_msg")!))")
                            
                        }else {
                            
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            return result("")
                            
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

class paypalModal {

    var paypal_id = ""
    var email = ""
    var Cdefault = "";
    
    init(data:NSDictionary) {
        
        paypal_id = String(describing: data["paypal_id"] as! NSObject)
        email = String(describing: data["email"] as! NSObject)
        Cdefault = String(describing: data["default"] as! NSObject)
        
        
    }

}
