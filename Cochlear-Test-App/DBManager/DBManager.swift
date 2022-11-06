//
//  DBManager.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 06/11/2022.
//

import RealmSwift

class DBManager {
    private var database: Realm
    
    static let shared = DBManager()
    
    private init() {
        database = try! Realm()
    }
    
    func getDataFromDB() -> Results<RealmLocationModel> {
        let results: Results<RealmLocationModel> = database.objects(RealmLocationModel.self)
        return results
    }
    
    func getAllData() -> [RealmLocationModel] {
        let results: Results<RealmLocationModel> = database.objects(RealmLocationModel.self)
        var resultToSend = [RealmLocationModel]()
        for result in results{
            resultToSend.append(result)
        }
        return resultToSend
    }
    
    func getData(with locationName: String) -> [RealmLocationModel] {
        let results: Results<RealmLocationModel> = database.objects(RealmLocationModel.self)
        var resultToSend = [RealmLocationModel]()
        for result in results{
            if locationName.contains(result.locationName ?? "") {
                resultToSend.append(result)
            }
        }
        return resultToSend
    }
    
    func addData(object: RealmLocationModel, message: String = "") {
        if !DBManager.shared.isEmpty() {
            if !(DBManager.shared.getDataFromDB().contains(where: { locationModel in
                locationModel.locationName == object.locationName
            })) {
                writeToDB(with: object, message: message)
            }
        } else {
            writeToDB(with: object, message: message)
        }
    }
    
    @discardableResult
    private func writeToDB(with object: RealmLocationModel, message: String) -> Bool {
        do {
            try database.write {
                object.notes = message
                database.add(object, update: .all)
            }
        } catch {
            return false
        }
        return true
    }
    
    func deleteAllFromDB() {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: RealmLocationModel) {
        try! database.write {
            database.delete(object)
        }
    }
    
    func isEmpty() -> Bool {
        return database.isEmpty
    }
}
