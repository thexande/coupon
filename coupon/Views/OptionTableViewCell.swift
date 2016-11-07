//
//  OptionTableViewCell.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!
    
    var option: Object?
    var optionContent: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(option?.value(forKey: "content") as? String == nil) {
            optionContent = "No Option Title"
        } else {
            optionContent = option?.value(forKey: "content") as? String
        }
        optionLabel.text = optionContent
    }
}
