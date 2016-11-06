//
//  Offer.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import RealmSwift

class Offer: Object {
    let retailers = LinkingObjects(fromType: Retailer.self, property: "offers")
    dynamic var name = ""
    dynamic var id = 0
    dynamic var offer_description = ""
    dynamic var expiration = ""
    dynamic var large_url = ""
    dynamic var launched_at = ""
    dynamic var purchase_type = ""
    let rewards = List<Reward>()
}
