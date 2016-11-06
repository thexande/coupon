//
//  RetailerTableViewCell.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class RetailerTableViewCell: UITableViewCell {
    public var retailer: Object?
    
    @IBOutlet weak var retailerNameLabel: UILabel!
    @IBOutlet weak var retailerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.retailerNameLabel.text = retailer?.value(forKey: "name") as! String?
        
        let remoteImageURLString = retailer?.value(forKey: "icon_url")  as! String?
        if(remoteImageURLString != nil) {
            let remoteImageURL = NSURL(string: remoteImageURLString!)
            self.retailerImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "Appicon"), options: SDWebImageOptions.progressiveDownload)
        }
    }
}
