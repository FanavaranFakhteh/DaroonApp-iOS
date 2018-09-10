//
//  DAHeaderTableViewCell.swift
//  DaroonApp
//
//  Created by Masoud on 8/14/18.
//  Copyright © 2018 Masoud Sheikh Hosseini. All rights reserved.
//

import UIKit

class DAHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var priceLabel: DALabel!
    @IBOutlet weak var infoLabel: DALabel!
    
    var object: DAPayment! {
        didSet {
            priceLabel.text = object.getAmount().persianString()
            
            if let email = object.getEmail() {
                infoLabel.text = email
            } else {
                infoLabel.text = object.getMobile().persianString()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
