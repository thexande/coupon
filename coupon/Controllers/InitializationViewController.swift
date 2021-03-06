//
//  InitializationViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import RealmSwift

class InitializationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let realm = try! Realm()
        if(realm.objects(Retailer.self).count == 0) {
            print("starting")
            //load retailers, offers and locations into Realm with associations
            let processedRetailers = RetailerTranslatorHelper.translateRetailer(data: ReadJSONHelper.getAllRetailers()!)
            RealmDatabaseHelper.writeRetailers(retailers: processedRetailers!)
            
            let processedOffers = OfferTranslatorHelper.translateOffer(data: ReadJSONHelper.getAllOffers()!)
            RealmDatabaseHelper.writeRetailers(retailers: processedOffers!)
            
            let processedLocations = LocationTranslatorHelper.translateLocation(data: ReadJSONHelper.getAllLocaitons()!)
            RealmDatabaseHelper.writeLocations(locations: processedLocations!)
            
            print("all done")
            self.performSegue(withIdentifier: "showRetailers", sender: self)
        } else {
            self.performSegue(withIdentifier: "showRetailers", sender: self)
        }
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
