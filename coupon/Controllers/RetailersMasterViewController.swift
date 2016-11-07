//
//  RetailersMasterViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import SDWebImage
import DZNEmptyDataSet
import RealmSwift

class RetailersMasterViewController:
    
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchBarDelegate,
    CustomSearchControllerDelegate,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate {
    
    // Interface Outlets
    @IBOutlet weak var retailerTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    // realm datasource
    let realm = try! Realm()
    var allRetailers: Results<Retailer>?
    var filteredRetailers: Results<Retailer>?

    var customSearchController: CustomSearchController!
    var searchController: UISearchController!
    var shouldShowSearchResults: Bool = false
    var selectedRetailer: Object?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allRetailers = realm.objects(Retailer.self)
        retailerTableView.register(UINib(nibName: "RetailerTableViewCell", bundle: nil), forCellReuseIdentifier: "RetailerCell")
        retailerTableView.delegate = self
        retailerTableView.dataSource = self
        retailerTableView.separatorColor = UIColor.white
        
        //empty data set
        retailerTableView.emptyDataSetSource = self
        retailerTableView.emptyDataSetDelegate = self
        
        // Do any additional setup after loading the view.
        // Our custom search bar configuration
        configureCustomSearchController()
        // Reload the tableview.
        retailerTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRetailerDetail") {
            let destination = segue.destination as! RetailerDetailViewController
                destination.selectedRetailer = selectedRetailer
        }
    }
    
    // recieve voice text from speech input
    public func recieveVoiceText(voice: String) {
        // load table view results from user speech string
        let trimmedVoice = voice.filter { $0 != Character(" ") }
        if(allRetailers == nil) {
            let realm = try! Realm()
            allRetailers = realm.objects(Retailer.self)
            filteredRetailers = allRetailers?.filter(NSPredicate(format: "name CONTAINS[c] %@", voice))
            shouldShowSearchResults = true
        }
    }
    
    // DZNDataSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No cars have matched your search. \n\n\n\n\n\n\n\n"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    
    // UITableView Delegate and Datasource functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            if(self.filteredRetailers == nil) {
                return 0
            } else {
                return self.filteredRetailers!.count
            }
        }
        else {
            return self.allRetailers!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerCell", for: indexPath) as! RetailerTableViewCell
        if shouldShowSearchResults {
            let currentRetailer = self.filteredRetailers?[indexPath.row]
            cell.retailer = currentRetailer
        }
        else {
            let currentRetailer = self.allRetailers?[indexPath.row]
            cell.retailer = currentRetailer
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(shouldShowSearchResults) {
            selectedRetailer = filteredRetailers?[indexPath.row]
            self.performSegue(withIdentifier: "showRetailerDetail", sender: self)
        } else {
            selectedRetailer = allRetailers?[indexPath.row]
            self.performSegue(withIdentifier: "showRetailerDetail", sender: self)
        }
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
        retailerTableView.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            retailerTableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        retailerTableView.reloadData()
    }
    
    func didChangeSearchText(_ searchText: String) {
        filteredRetailers = allRetailers?.filter(NSPredicate(format: "name CONTAINS[c] %@", searchText))
        // Reload the tableview.
        retailerTableView.reloadData()
    }
}
