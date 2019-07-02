//
//  Location.swift
//  Treads
//
//  Created by Admin on 7/2/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation
import RealmSwift
class Location:Object {
    
    @objc dynamic public private(set) var  latitude :Double = 0.0
    @objc dynamic public private(set) var longitude :Double = 0.0
   
    convenience init(latitude:Double , longitude:Double)
    {
        self.init()
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
