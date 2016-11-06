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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
