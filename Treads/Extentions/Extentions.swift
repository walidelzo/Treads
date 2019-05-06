//
//  Extentions.swift
//  Treads
//
//  Created by Admin on 5/5/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation
extension Double{
    
    func metersToMiles(places:Int)->Double{
        let divsor = pow(10, Double(places))
        return ((self/1604.34) * divsor).rounded() / divsor
    }
    
}

