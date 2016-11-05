//
//  OfferTranslatorHelper.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class OfferTranslatorHelper {
    static func translateOffer(data: JSON?) -> [Offer]? {
        var offers = [Offer]()
        let realm = try! Realm()
        var allRetailers = realm.objects(Retailer.self)
        
        for offerObject in (data?.array)! {
            let offer = Offer()
            offer.name = offerObject["name"].stringValue
            offer.id = offerObject["id"].intValue
            
            
            var linkedRetailers = [Retailer]()
            let retailerIds = offerObject["retailers"].arrayValue
            for id in retailerIds {
                let predicate = NSPredicate(format: "id = %d", id.intValue)
                let linkedRetailersFromId = allRetailers.filter(predicate)
                for retailer in linkedRetailersFromId {
          
                        try! realm.write {
                            retailer.offers.append(offer)
                        }
                    
                    
                    
                }
            }
            
            
            offers.append(offer)
        }
        return offers
    }
}
