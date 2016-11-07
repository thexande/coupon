//
//  RewardDetailViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class RewardDetailViewController: UIViewController {

    @IBOutlet weak var optionTableView: UITableView!
    
    var selectedReward: Object!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "woot"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
