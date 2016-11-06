//
//  Reward.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import RealmSwift

class Reward: Object {
    dynamic var content = ""
    let options = List<Option>()
}
