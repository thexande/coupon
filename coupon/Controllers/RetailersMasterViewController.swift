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
    UISearchResultsUpdating,
    UISearchBarDelegate,
    CustomSearchControllerDelegate,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate {

    @IBOutlet weak var retailerTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    
    // realm datasource
    let realm = try! Realm()
    var allRetailers: Results<Retailer>?
    var filteredRetailers: Results<Retailer>?

    var customSearchController: CustomSearchController!
    var searchController: UISearchController!
    var shouldShowSearchResults: Bool = false
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: DZNDataSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No cars have matched your search. \n\n\n\n\n\n\n\n"
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
            return self.filteredRetailers!.count
        }
        else {
            return self.allRetailers!.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RetailerCell", for: indexPath) as! RetailerTableViewCell
        if shouldShowSearchResults {
//            let currentCar = self.filteredCarArray?[indexPath.row]
//
//            let remoteImageURLString = currentCar?["image_url"].stringValue
//            if (remoteImageURLString != nil) {
//                let remoteImageURL = NSURL(string: remoteImageURLString!)
//                cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "car"), options: SDWebImageOptions.progressiveDownload)
//            }
//            cell.car = currentCar
        }
        else {
            let currentRetailer = self.allRetailers?[indexPath.row]
            
//            
//            let currentCar = self.carDataArray?[indexPath.row]
//            let remoteImageURLString = currentCar?["image_url"].stringValue
//            if (remoteImageURLString != nil) {
//                let remoteImageURL = NSURL(string: remoteImageURLString!)
//                cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "car"), options: SDWebImageOptions.progressiveDownload)
//            }
//            
//            
//            
//            cell.car = currentCar
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    // search controller
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Include the search bar within the navigation bar.
        //navigationItem.titleView = searchController.searchBar;
        
        // Place the search bar view to the tableview headerview.
        retailerTableView.tableHeaderView = searchController.searchBar
    }
    
    func configureCustomSearchController() {
        let screenSize: CGRect = UIScreen.main.bounds
        
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: screenSize.width, height: 50.0), searchBarFont: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0))
        customSearchController.customSearchBar.placeholder = "Search For Your Next Car!"
        searchView.addSubview(customSearchController.customSearchBar)
        customSearchController.customDelegate = self
    }
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        retailerTableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        retailerTableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            retailerTableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else {
            return
        }
        
        
//        filteredCarArray = carDataArray?.filter({ (car) -> Bool in
//            let carMake: NSString = car["make"].stringValue as NSString
//            let carModel: NSString = car["model"].stringValue as NSString
//            let carYear: NSString = car["year"].stringValue as NSString
//            let carDataString: String = "\(carMake),\(carModel),\(carYear)" as String
//            
//            return (carDataString.score(searchString.trimmingCharacters(in: .whitespaces)) > 0.1)
// 
//        })

        
        // Reload the tableview.
        retailerTableView.reloadData()
    }
    
    
    // MARK: CustomSearchControllerDelegate functions
    
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
        
//        filteredCarArray = carDataArray?.filter({ (car) -> Bool in
//            let carMake: NSString = car["make"].stringValue as NSString
//            let carModel: NSString = car["model"].stringValue as NSString
//            let carYear: NSString = car["year"].stringValue as NSString
//            let carDataString: String = "\(carMake),\(carModel),\(carYear)" as String
//            return (carDataString.score(searchText.trimmingCharacters(in: .whitespaces)) > 0.1)
//        })
        
        // Reload the tableview.
        retailerTableView.reloadData()
    }
}
