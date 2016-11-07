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
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var offerCategoriesLabel: UILabel!
    @IBOutlet weak var offerDescriptionLabel: UILabel!
    
    public var selectedOffer: Object?
    var allRewards: List<Reward>?
    var selectedOfferCategories: List<Category>?
    var selectedOfferCategoriesString: String?
    var selectedReward: Object?
    
    // no options alert
    let noOptionAlert = UIAlertController(title: "No Options Available", message: "Sorry, no options are available for the selected reward.", preferredStyle: UIAlertControllerStyle.alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOfferImage()
        setOfferDescription()
        setNavTitle()
        // get all rewards
        allRewards = selectedOffer?.value(forKey: "rewards") as! List<Reward>?
        selectedOfferCategories = selectedOffer?.value(forKey: "categories") as! List<Category>?
        
        // set categories
        selectedOfferCategoriesString = createCategoryString(categories: selectedOfferCategories!)
        offerCategoriesLabel.text = selectedOfferCategoriesString
        
        // set up table
        rewardTableView.register(UINib(nibName: "RewardTableViewCell", bundle: nil), forCellReuseIdentifier: "RewardCell")
        rewardTableView.delegate = self
        rewardTableView.dataSource = self
        rewardTableView.separatorColor = UIColor.white
        
        //empty data set
        rewardTableView.emptyDataSetSource = self
        rewardTableView.emptyDataSetDelegate = self
        rewardTableView.reloadData()
        
        //configure alert
        noOptionAlert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRewardDetail") {
            let destination = segue.destination as! RewardDetailViewController
            destination.selectedReward = selectedReward
        }
    }
    
    // view data methods
    func createCategoryString(categories: List<Category>) -> String {
        var allCategoryString: String = ""
        for category in categories {
            var categoryString = category.value(forKey: "name") as! String
            categoryString += " "
            allCategoryString += categoryString
        }
        return allCategoryString
    }
    
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
        let currentReward = self.allRewards?[indexPath.row]
        cell.reward = currentReward
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedReward = allRewards?[indexPath.row]
        let selectedRewardOffers = selectedReward?["options"] as! List<Option>
        
        if(selectedRewardOffers.count == 0){
            self.present(noOptionAlert, animated: true, completion: nil)
        } else {
        self.performSegue(withIdentifier: "showRewardDetail", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
