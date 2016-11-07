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
    var rewardContent: String?
    
    @IBOutlet weak var rewardTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rewardTitleLabel.numberOfLines = 0
        // Initialization code
        self.contentView.autoresizingMask = UIViewAutoresizing.flexibleHeight

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if(reward?.value(forKey: "content") as? String == nil) {
            rewardContent = "No Reward Title"
        } else {
            rewardContent = reward?.value(forKey: "content") as? String
        }
        rewardTitleLabel.text = rewardContent
    }
    
}
