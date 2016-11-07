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
    
    @IBOutlet weak var rewardTableView: UITableView!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    @IBOutlet weak var offerImage: UIImageView!
    
    public var selectedOffer: Object?
    var allRewards: List<Reward>?
    
    // no options alert
    let noLocationAlert = UIAlertController(title: "No Options Available", message: "Sorry, no options are available for the selected reward.", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOfferImage()
        setOfferDescription()
        setNavTitle()
        allRewards = selectedOffer?.value(forKey: "rewards") as! List<Reward>?
        // set up table
        rewardTableView.register(UINib(nibName: "RewardTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardCell")
        rewardTableView.delegate = self
        rewardTableView.dataSource = self
        rewardTableView.separatorColor = UIColor.white
        
        //empty data set
        rewardTableView.emptyDataSetSource = self
        rewardTableView.emptyDataSetDelegate = self
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
    
    // DZNDataSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No rewards are available. \n\n\n\n\n\n\n\n"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    // UITableView Delegate and Datasource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allRewards!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RewardCell", for: indexPath) as! RewardTableViewCell

        print(self.allRewards?[indexPath.row])
        
        let currentReward = self.allRewards?[indexPath.row]
        
        cell.reward = currentReward
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedOffer = allRewards?[indexPath.row]
        self.performSegue(withIdentifier: "showOfferDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}
