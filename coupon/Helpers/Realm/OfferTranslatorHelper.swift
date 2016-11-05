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
        var allRetailers = realm.objects(Retailer.self)
        
        for offerObject in (data?.array)! {
            let linkedRetailers = allRetailers.filter(NSPredicate(format: "id = %@", 25))
            
            print(linkedRetailers, "linkded here")
            let offer = Offer()
            offer.name = offerObject["name"].stringValue
            offer.id = offerObject["id"].intValue
            offers.append(offer)
        }
        return offers
    }
}
