//
//  ViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let processedRetailers = RetailerTranslatorHelper.translateRetailer(data: ReadJSONHelper.getAllRetailers()!)
        RealmDatabaseHelper.writeRetailers(retailers: processedRetailers!)
        
        let processedOffers = OfferTranslatorHelper.translateOffer(data: ReadJSONHelper.getAllOffers()!)
        RealmDatabaseHelper.writeRetailers(retailers: processedOffers!)
        
        //print(ReadJSONHelper.getAllRetailers()!.arrayValue.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

