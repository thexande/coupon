//
//  RetailerDetailViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet
import RealmSwift

class RetailerDetailViewController:
    
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchBarDelegate,
    CustomSearchControllerDelegate,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate {
    
    // Interface Outlets
    @IBOutlet weak var retailerBannerImageView: UIImageView!
    @IBOutlet weak var retailerTagLineView: UIVisualEffectView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var offerTableView: UITableView!
    
    // realm datasource
    let realm = try! Realm()
    var allOffers: List<Offer>?
    var filteredOffers: Results<Offer>?
    // Selected Retailer
    var selectedRetailer: Object?
    // Selected Offer
    var selectedOffer: Object?
    
    
    
    // search
    var customSearchController: CustomSearchController!
    var searchController: UISearchController!
    var shouldShowSearchResults: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allOffers = selectedRetailer?.value(forKey: "offers") as! List<Offer>?
        
        offerTableView.register(UINib(nibName: "OfferTableViewCell", bundle: nil), forCellReuseIdentifier: "OfferCell")
        offerTableView.delegate = self
        offerTableView.dataSource = self
        offerTableView.separatorColor = UIColor.white
        
        //empty data set
        offerTableView.emptyDataSetSource = self
        offerTableView.emptyDataSetDelegate = self
        
        // Do any additional setup after loading the view.
        // Our custom search bar configuration
        configureCustomSearchController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: DZNDataSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No offers have matched your search. \n\n\n\n\n\n\n\n"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            if(self.filteredOffers == nil) {
                return 0
            } else {
                return self.filteredOffers!.count
            }
        }
        else {
            return self.allOffers!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OfferCell", for: indexPath) as! OfferTableViewCell
        if shouldShowSearchResults {
            let currentOffer = self.filteredOffers?[indexPath.row]
            cell.offer = currentOffer
        }
        else {
            let currentOffer = self.allOffers?[indexPath.row]
            cell.offer = currentOffer
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showRetailerDetail", sender: self)
        print(self.allOffers?[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    //custom search bar functions / configuration
    func configureCustomSearchController() {
        let screenSize: CGRect = UIScreen.main.bounds
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: 50.0), searchBarFont: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0))
        customSearchController.customSearchBar.placeholder = "Search For Retailers!"
        searchView.addSubview(customSearchController.customSearchBar)
        customSearchController.customDelegate = self
    }
    
    // CustomSearchControllerDelegate functions
    func didStartSearching() {
        shouldShowSearchResults = true
        offerTableView.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            offerTableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        offerTableView.reloadData()
    }
    
    func didChangeSearchText(_ searchText: String) {
        filteredOffers = allOffers?.filter(NSPredicate(format: "name CONTAINS %@", searchText))
        // Reload the tableview.
        offerTableView.reloadData()
    }
}
