//
//  OfferDetailViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage
import DZNEmptyDataSet

class OfferDetailViewController:
    
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerImage: UIImageView!
    public var selectedOffer: Object?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOfferImage()
        setOfferDescription()
        setNavTitle()
        



        print(selectedOffer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // view data methods
    func setOfferImage() {
        let remoteImageURLString = selectedOffer?.value(forKey: "large_url")  as! String?
        if(remoteImageURLString != nil) {
            let remoteImageURL = NSURL(string: remoteImageURLString!)
            offerImage.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "Appicon"), options: SDWebImageOptions.progressiveDownload)
        }
    }
    
    func setOfferDescription() {
        let offerDescription = selectedOffer?.value(forKey: "offer_description") as! String
        offerDescriptionLabel.text = offerDescription
    }
    
    func setNavTitle() {
        let offerTitle = selectedOffer?.value(forKey: "name") as! String
        self.title = offerTitle
    }
    
}
