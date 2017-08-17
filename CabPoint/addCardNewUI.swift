//
//  addCardNewUI.swift
//  CabPoint
//
//  Created by abdur rehman on 8/1/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import UIKit

class addCardNewUI: UIViewController , UITableViewDataSource , UITableViewDelegate,  PayPalProfileSharingDelegate{

    
    
    
    var payPalConfiguration: PayPalConfiguration?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        payPalConfiguration = PayPalConfiguration()
        // See PayPalConfiguration.h for details and default values.
        // Minimally, you will need to set three merchant information properties.
        // These should be the same values that you provided to PayPal when you registered your app.
        payPalConfiguration?.acceptCreditCards = true
        payPalConfiguration?.defaultUserEmail = "arslan.jd@gmail.com"
        payPalConfiguration?.merchantName = "Cab Point by Cabigate!"
        payPalConfiguration?.merchantPrivacyPolicyURL = URL(string: "https://www.omega.supreme.example/privacy")
        payPalConfiguration?.merchantUserAgreementURL = URL(string: "https://www.omega.supreme.example/user_agreement")
        
    }
    
    //  Converted with Swiftify v1.0.6423 - https://objectivec2swift.com/
    // MARK: - PayPalProfileSharingDelegate methods
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        // User cancelled login. Dismiss the PayPalProfileSharingViewController, breathe deeply.
        dismiss(animated: true) { _ in }
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable: Any]) {
        // The user has successfully logged into PayPal, and has consented to profile sharing.
        // Your code must now send the authorization response to your server.
       sendAuthorization(toServer: profileSharingAuthorization )
        // Be sure to dismiss the PayPalProfileSharingViewController.
        dismiss(animated: true) { _ in }
    }

    
    
    //  Converted with Swiftify v1.0.6421 - https://objectivec2swift.com/
    // SomeViewController.m
    
     func obtainConsent() {
        
        let scopeValues = Set<AnyHashable>([kPayPalOAuth2ScopeOpenId, kPayPalOAuth2ScopeEmail, kPayPalOAuth2ScopeAddress, kPayPalOAuth2ScopePhone , kPayPalOAuth2ScopeFuturePayments])
        var psViewController: PayPalProfileSharingViewController!
        
        psViewController = PayPalProfileSharingViewController(scopeValues: scopeValues, configuration: payPalConfiguration!, delegate: self)
        // Present the PayPalProfileSharingViewController
        present(psViewController!, animated: true) { _ in }
    }

    
 

    
    //  Converted with Swiftify v1.0.6421 - https://objectivec2swift.com/
    // SomeViewController.m
    
    func sendAuthorization(toServer authorization: [AnyHashable: Any]) {
       
        print(authorization)
    let u = authorization["response"] as! NSDictionary
    
        let code = String(describing: u["code"] as! NSObject)

        print(code)
        
        let metadataID: String = PayPalMobile.clientMetadataID()
        print(metadataID)
        
    paypalMianIntegration.object.AddPaypalCard(mainPaypalCode: code, MetaId: metadataID) { (result) in
        
        if(result == ""){
            
           let lert =  alert.object.alertForSignin(title: "Good!", message: "Paypal Added in your account")
            
        self.present(lert, animated: true, completion: nil)
            
        }
        
        }
    
        
        
        
        
    }

    
 
    
    var environment:String = PayPalEnvironmentSandbox {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
      PayPalMobile.preconnect(withEnvironment: environment)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    //AddCoustomCard
    
//    let controller = storyboard?.instantiateViewController(withIdentifier: "DIfferentPaymentMethod") as! addCardNewUI
//    
//    self.navigationController?.pushViewController(controller, animated: true)
//    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            
            return cell1
        }else{
            
            
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath)
            
            
            return cellTwo
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 0){
            
                let controller = storyboard?.instantiateViewController(withIdentifier: "AddCoustomCard") as! paymentController
            
                self.navigationController?.pushViewController(controller, animated: true)
            
        }else{
            
         obtainConsent()
            
            
           // paypalPaymentSystem()
        }
        
    }
    
    func paypalPaymentSystem(){
        
        var fare = booking.object.fareEstimate
        
        
        if(fare == ""){
            fare = "1.0"
            
            
            paypalsubSystem(afre: fare)
        }else {
            
            paypalsubSystem(afre: booking.object.fareEstimate)
        }
        
    }
    
        func paypalsubSystem(afre:String){
            // Optional: include multiple items
            let item1 = PayPalItem(name: "Cab Point Ride Fare!", withQuantity: 1, withPrice: NSDecimalNumber(string: "\(afre)"), withCurrency: "GBP", withSku: "Hip-0037")
            
            
            let items = [item1]
            let subtotal = PayPalItem.totalPrice(forItems: items)
            
            // Optional: include payment details
            let shipping = NSDecimalNumber(string: "0.0")
            let tax = NSDecimalNumber(string: "0.0")
            let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
            
            let total = subtotal.adding(shipping).adding(tax)
            
            let payment = PayPalPayment(amount: total, currencyCode: "GBP", shortDescription: "Cab Point Ride Fare!", intent: .sale)
            
            payment.items = items
            payment.paymentDetails = paymentDetails
            
            if (payment.processable) {
                let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfiguration, delegate: self as! PayPalPaymentDelegate)
                present(paymentViewController!, animated: true, completion: nil)
            }
            else {
                // This particular payment will always be processable. If, for
                // example, the amount was negative or the shortDescription was
                // empty, this payment wouldn't be processable, and you'd want
                // to handle that here.
                print("Payment not processalbe: \(payment)")
            }
            //////
        }
    
    
}
