//
//  Run.swift
//  Treads
//
//  Created by Admin on 5/20/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation
import RealmSwift

class Run:Object {
    // some properties
    @objc dynamic  var id = ""
    @objc dynamic  var pace = 0
    @objc dynamic  var distance = 0.0
    @objc dynamic  var duration = 0
    @objc dynamic  var date = NSDate()
    
    override class func primaryKey()->String
        
    {
        return "id"
    }
    
//    override class func indexedProperties()->[String]
//    {
//        return ["pace" , "duration" , "distance"]
//
//    }
    
    convenience init(distance:Double , pace:Int , durtion:Int)
    {
        self.init()
        self.id = UUID().uuidString.lowercased()
        self.pace = pace
        self.distance = distance
        self.duration = durtion
        self.date = NSDate()
        
    }
    
    static func addedRunToRealm(distace:Double, pace:Int, duration:Int){
        
        REALM_QUEUE.async {
            
            let run = Run(distance: distace, pace: pace, durtion: duration)
            do
            {
                let realm = try Realm()
                try realm.write {
                    realm.add(run)
                    print("data saved to Realm...")
                   // print(realm.configuration.fileURL!)
                }
                
            }catch{
                debugPrint("An Error occured when we save Run to RealM")
            }
            
        }
    }
    
    static func getAllRuns() -> Results<Run>?{
        do {
            let realm = try Realm()
            let runs = realm.objects(Run.self)
           // print(realm.configuration.fileURL!)
            return runs
        } catch{
            return nil
        }
    }
    
    
}
