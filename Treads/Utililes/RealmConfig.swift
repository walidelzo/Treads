//
//  RealmConfig.swift
//  Treads
//
//  Created by Admin on 7/2/19.
//  Copyright © 2019 NanoSoft. All rights reserved.
//

import Foundation
import RealmSwift
class realmConfig{
    static var runDataconfig:Realm.Configuration{
        let realmPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(REALMPATHCONFIG)
        let config = Realm.Configuration(
            fileURL: realmPath,
            schemaVersion: 0,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 0) {
                    //Nothing to do
                    //Realm with automatically detect new properties and remove properties
                }
        })
        return config
    }
}