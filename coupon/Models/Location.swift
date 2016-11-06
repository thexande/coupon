//
//  Location.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import RealmSwift
import MapKit

class Location: Object {
    dynamic var id = 0
    dynamic var latitude = 0.000
    dynamic var longitude = 0.000
    let locations = LinkingObjects(fromType: Retailer.self, property: "locations")
    var coordinate:CLLocation {
        return CLLocation(latitude: Double(latitude), longitude: Double(longitude));
    }
}
