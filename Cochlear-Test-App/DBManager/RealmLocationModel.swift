//
//  RealmLocationModel.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 06/11/2022.
//

import RealmSwift

class RealmLocationModel: Object {
    @objc dynamic var locationName: String?
    @objc dynamic var notes: String?
    @objc dynamic var longitude: String?
    @objc dynamic var latitude: String?

    override class func primaryKey() -> String? {
            return "locationName"
        }

}
