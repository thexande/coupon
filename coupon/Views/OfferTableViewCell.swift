//
//  OfferTableViewCell.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class OfferTableViewCell: UITableViewCell {
    
    public var offer: Object?
    
    @IBOutlet weak var offerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        offerTitleLabel.text = offer?["name"] as! String?
        
        // Configure the view for the selected state
    }
    
}
