//
//  LocationTranslatorHelper.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class LocationTranslatorHelper {
    static func translateLocation(data: JSON?) -> [Location]? {
        var locations = [Location]()
        let realm = try! Realm()
        let allRetailers = realm.objects(Retailer.self)
        print("beginning location association map")
        for locationObject in (data?.arrayValue)! {
            let location = Location()
            location.latitude = locationObject["lat"].doubleValue
            location.longitude = locationObject["long"].doubleValue
            location.id = locationObject["id"].intValue
            
            let retailerId = locationObject["retailer_id"].intValue
            print("retailer id here", retailerId)
            let predicate = NSPredicate(format: "id = %d", retailerId)
            let linkedRetailersFromId = allRetailers.filter(predicate)
            for retailer in linkedRetailersFromId {
                // write relation
                try! realm.write {
                    retailer.locations.append(location)
                }
            }
            locations.append(location)
        }
        print("end location association map")
        return locations
    }
}
