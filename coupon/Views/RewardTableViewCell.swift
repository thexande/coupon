//
//  RewardTableViewCell.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class RewardTableViewCell: UITableViewCell {
    
    var reward: Object?
    
    @IBOutlet weak var rewardTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        print(reward)
        
        var rewardContent = reward?.value(forKey: "content") as? String
        
        if(rewardContent == nil) {
            rewardContent = "No Reward Title"
        }
        rewardTitleLabel.text = rewardContent
    }
    
}
