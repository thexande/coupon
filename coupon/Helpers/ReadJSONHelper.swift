//
//  ReadJSONHelper.swift
//  coupon
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import SwiftyJSON

class ReadJSONHelper {
    static func getAllRetailers() -> JSON? {
        if let path = Bundle.main.path(forResource: "Retailers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    return jsonObj
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    static func getAllOffers() -> JSON? {
        if let path = Bundle.main.path(forResource: "Offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    return jsonObj
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    static func getAllLocaitons() -> JSON? {
        if let path = Bundle.main.path(forResource: "Locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    print(jsonObj)
                    return jsonObj
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
