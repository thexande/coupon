//
//  InitializationViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class InitializationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Load all json data into realm before segue
        print("starting")
        let processedRetailers = RetailerTranslatorHelper.translateRetailer(data: ReadJSONHelper.getAllRetailers()!)
        RealmDatabaseHelper.writeRetailers(retailers: processedRetailers!)
        
        let processedOffers = OfferTranslatorHelper.translateOffer(data: ReadJSONHelper.getAllOffers()!)
        RealmDatabaseHelper.writeRetailers(retailers: processedOffers!)
        print("all done")
        self.performSegue(withIdentifier: "showRetailers", sender: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
