//
//  RewardDetailViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class RewardDetailViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource {

    @IBOutlet weak var optionTableView: UITableView!
    
    var selectedReward: Object!
    var allOptions: List<Option>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(reward: selectedReward)
        allOptions = setOptions(reward: selectedReward)
        
        // Do any additional setup after loading the view.
        // set up table
        optionTableView.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "OptionCell")
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.separatorColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setOptions(reward: Object) -> List<Option> {
        return reward.value(forKey: "options") as! List<Option>!
    }
    
    func setTitle(reward: Object) {
        let title = reward.value(forKey: "content") as! String
        self.title = title
    }
    
    // UITableView Delegate and Datasource functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allOptions!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentOption = self.allOptions?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath) as! OptionTableViewCell
        cell.option = currentOption
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
