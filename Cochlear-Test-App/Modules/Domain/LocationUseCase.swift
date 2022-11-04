//
//  LocationUseCase.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import Foundation

protocol LocationUseCase {
    func getLocationsFromJSON(method: FetchingType, completion: @escaping (LocationModel?, String?) -> ())
}

class DefaultLocationUseCase: LocationUseCase {
    
    private var locationRepository: LocationRepository

    init(locationRepository: LocationRepository) {
        self.locationRepository = locationRepository
    }

    func getLocationsFromJSON(method: FetchingType, completion: @escaping (LocationModel?, String?) -> ()) {
        locationRepository.getLocationsFromJSON(from: method) { response, errorMsg in
            if let errorMsg = errorMsg {
                completion(nil, errorMsg)
                return
            }
            completion(response, nil)
        }
    }
}
