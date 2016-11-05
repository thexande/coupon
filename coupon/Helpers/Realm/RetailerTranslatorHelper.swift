//
//  RetailerTranslatorHelper.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import SwiftyJSON

class RetailerTranslatorHelper {
    static func translateRetailer(data: JSON?) -> [Retailer]? {
        var retailers = [Retailer]()
        for retailerObject in (data?.array)! {
            let retailer = Retailer()
            retailer.name = retailerObject["name"].stringValue
            retailer.id = retailerObject["id"].intValue
            retailers.append(retailer)
        }
        return retailers
    }
}
