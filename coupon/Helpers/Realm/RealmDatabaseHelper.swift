//
//  RealmDatabaseHelper.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabaseHelper {
    static func writeRetailers(retailers: [Object]) {
        let realm = try! Realm()
        print("Path to realm file: " + realm.configuration.fileURL!.absoluteString)
        for retailer in retailers {
            try! realm.write {
                realm.add(retailer)
            }
        }
    }
    static func writeOffers(offers: [Object]) {
        let realm = try! Realm()
        for offer in offers {
            try! realm.write {
                realm.add(offer)
            }
        }
    }
    //static func writeRetailerRelations()
}
