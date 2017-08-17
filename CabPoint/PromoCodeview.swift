//
//  PromoCodeview.swift
//  CabPoint
//
//  Created by abdur rehman on 8/15/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import UIKit

class PromoCodeview: UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tablevIEW: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        PromoController.object.latestPromotions { (result) in
            
            
            if(result == true){
                
                self.tablevIEW.reloadData()
                
            }
        }
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PromoController.latestPromotion.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as! promomain
        cell.configration(object: PromoController.latestPromotion[indexPath.row])
        return cell
        
        
    }

}
