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
        let allRetailers = realm.objects(Retailer.self)
        print("beginning relation map")
        for offerObject in (data?.arrayValue.prefix(100))! {
            let offer = Offer()
            offer.name = offerObject["name"].stringValue
            offer.id = offerObject["id"].intValue
            
            let retailerIds = offerObject["retailers"].arrayValue.map { $0.intValue }
                let predicate = NSPredicate(format: "id IN %@", retailerIds)
                let linkedRetailersFromId = allRetailers.filter(predicate)
                for retailer in linkedRetailersFromId {
                    // write relation
                    try! realm.write {
                        retailer.offers.append(offer)
                    }
                }
            
            
            offers.append(offer)
        }
        print("end relation map")
        return offers
    }
}
