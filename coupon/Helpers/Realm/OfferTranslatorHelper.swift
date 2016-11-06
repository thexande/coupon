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
        print("beginning offer relation map")
        for offerObject in (data?.arrayValue.prefix(100))! {
            let offer = Offer()
            offer.name = offerObject["name"].stringValue
            offer.id = offerObject["id"].intValue
            offer.offer_description = offerObject["description"].stringValue
            offer.expiration = offerObject["expiration"].stringValue
            offer.large_url = offerObject["large_url"].stringValue
            offer.launched_at = offerObject["launched_at"].stringValue
            offer.purchase_type = offerObject["purchase_type"].stringValue
            
            // create categories
            let categoriesArray = offerObject["categories"].arrayValue
            for category in categoriesArray {
                let categoryObject = Category()
                categoryObject.id = category["id"].intValue
                categoryObject.name = category["name"].stringValue
                categoryObject.sort_order = category["sort_order"].doubleValue
                offer.categories.append(categoryObject)
            }
            
            // create rewards
            let rewardsArray = offerObject["rewards"].arrayValue
            for reward in rewardsArray {
                let rewardObject = Reward()
                rewardObject.content = reward["content"].stringValue
                
                // create options
                let optionsArray = reward["options"].arrayValue
                for option in optionsArray {
                    let optionObject = Option()
                    optionObject.content = option["content"].stringValue
                    optionObject.id = option["id"].intValue
                    rewardObject.options.append(optionObject)
                }
                offer.rewards.append(rewardObject)
            }
            
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
        print("end offer relation map")
        return offers
    }
}
