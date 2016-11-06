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
            retailer.icon_url = retailerObject["icon_url"].stringValue
            retailer.exclusive_image_url = retailerObject["exclusive_image_url"].stringValue
            
            retailer.id = retailerObject["id"].intValue
            retailers.append(retailer)
        }
        return retailers
    }
}
