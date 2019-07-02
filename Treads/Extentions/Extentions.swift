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
extension Int{
    func formatTimeToString()->String{
        
        let durationHours = (self / 3600)
        let durationMinutes = (self % 3600) / 60
        let durationSeconds = ( self % 3600 ) % 60
        
        if durationSeconds < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String.init(format: "%02d:%02d",durationMinutes,durationSeconds)
            }else {
                return String.init(format: "%02d:%02d:%02d", durationHours,durationMinutes,durationSeconds)
            }
            
        }
        
    }
}

extension NSDate{
    func StringFromDate()->String{
        
        let calender = Calendar.current
        let month = calender.component(.month, from: self as Date)
        let day = calender.component(.day, from: self as Date)
        let year = calender.component(.year, from: self as Date)
        return "\(day)/\(month)/\(year)"
        
    }
}

