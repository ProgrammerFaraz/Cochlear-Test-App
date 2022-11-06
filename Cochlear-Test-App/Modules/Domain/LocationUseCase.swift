//
//  LocationUseCase.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import Foundation

protocol LocationUseCase {
    func getLocationsFromJSON(method: FetchingType, completion: @escaping (String?) -> ())
    func getLocationDetails(with name: String) -> [RealmLocationModel]
    func addLocationToLocal(locations: [Location])
    func addRealmLocationToLocal(realmLocations: [RealmLocationModel], message: String)
    func getAllLocations() -> [RealmLocationModel]
}

class DefaultLocationUseCase: LocationUseCase {
    
    private var locationRepository: LocationRepository

    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }

    /// Method to fetch locations from JSON
    func getLocationsFromJSON(method: FetchingType, completion: @escaping (String?) -> ()) {
        locationRepository.getLocationsFromJSON(from: method) { [weak self] response, errorMsg in
            if let errorMsg = errorMsg {
                completion(errorMsg)
                return
            }
            if let locations = response?.locations {
                self?.addLocationToLocal(locations: locations)
            }
        }
    }
    
    /// Method to fetch all locations
    func getAllLocations() -> [RealmLocationModel] {
        return locationRepository.getAllLocations()
    }
    
    /// Method to fetch location details
    func getLocationDetails(with name: String) -> [RealmLocationModel] {
        return locationRepository.getLocationDetails(with: name, from: .local) ?? []
    }

    func addLocationToLocal(locations: [Location]) {
            for location in locations {
                let realmLocation = RealmLocationModel()
                realmLocation.locationName = location.name
                realmLocation.longitude = "\(location.lng)"
                realmLocation.latitude = "\(location.lat)"
                realmLocation.notes = ""
                DBManager.shared.addData(object: realmLocation)
            }
    }
    
    func addRealmLocationToLocal(realmLocations: [RealmLocationModel], message: String) {
        for realmLocation in realmLocations {
            DBManager.shared.addData(object: realmLocation, message: message)
        }
    }
}
