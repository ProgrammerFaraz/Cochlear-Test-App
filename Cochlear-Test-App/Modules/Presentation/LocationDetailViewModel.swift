//
//  LocationDetailViewModel.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 05/11/2022.
//

import Foundation

protocol LocationDetailViewModel {
    func getLocationDetails()
    func addNotes(message: String)
}

class DefaultLocationDetailViewModel: LocationDetailViewModel {
    
    //MARK: - PROPERTIES
    private var locationUseCase: LocationUseCase
    var locationName: String = ""
    var location: RealmLocationModel?
        
    init(locationUseCase: LocationUseCase) {
        self.locationUseCase = locationUseCase
    }

    func getLocationDetails() {
        location = locationUseCase.getLocationDetails(with: locationName).first
    }
    
    func addNotes(message: String) {
        guard let location = location else {
            return
        }
        locationUseCase.addRealmLocationToLocal(realmLocations: [location], message: message)
    }
}
