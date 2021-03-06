//
//  Retailer.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import RealmSwift


class Retailer: Object {
    dynamic var name = ""
    dynamic var id = 0
    dynamic var icon_url = ""
    dynamic var exclusive_image_url = ""
    let offers = List<Offer>()
    let locations = List<Location>()
}
