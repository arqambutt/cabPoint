//
//  promo.swift
//  CabPoint
//
//  Created by abdur rehman on 8/15/17.
//  Copyright © 2017 CabPoint. All rights reserved.
//

import UIKit

class promomain: UITableViewCell {

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var coupanname: UILabel!
    @IBOutlet weak var expirydate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }

    func configration(object:promo) {
        
        coupanname.text = object.code
        desc.text = object.description
        expirydate.text = object.expiry
        
    }

}
