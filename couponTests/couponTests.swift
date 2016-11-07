//
//  couponTests.swift
//  couponTests
//
//  Created by Alexander Murphy on 11/5/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import XCTest
import RealmSwift
@testable import coupon

class couponTests: XCTestCase {
    var processedRetailers: [Object]?
    var processedOffers: [Object]?
    var processedLocations: [Object]?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //load retailers, offers and locations into Realm with associations
        processedRetailers = RetailerTranslatorHelper.translateRetailer(data: ReadJSONHelper.getAllRetailers()!)
        processedOffers = OfferTranslatorHelper.translateOffer(data: ReadJSONHelper.getAllOffers()!)
        processedLocations = LocationTranslatorHelper.translateLocation(data: ReadJSONHelper.getAllLocaitons()!)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let retailerOne = processedRetailers?[0]["name"] as! String
        let offerOne = processedOffers?[0]["name"] as! String
        let locationOne = processedLocations?[0]["id"] as! Int
        
        XCTAssertEqual(retailerOne, "H-E-B")
        XCTAssertEqual(offerOne, "RushÂ® Bowls")
        XCTAssertEqual(locationOne, 22920)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
