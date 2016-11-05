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
    dynamic var name = ""
    dynamic var id = 0
    let retailers = LinkingObjects(fromType: Retailer.self, property: "offers")
}
