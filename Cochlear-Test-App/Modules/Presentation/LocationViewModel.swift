//
//  LocationViewModel.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 31/10/2022.
//

import Foundation
import CoreLocation

protocol LocationViewModel {
    func getLocations()
}

class DefaultLocationViewModel: LocationViewModel {
    
    //MARK: - PROPERTIES
    private var locationUseCase: LocationUseCase
    var locationService: LocationService
    var locations = [RealmLocationModel]()
    
    //MARK: - CALLBACKS
    var sendCoordinatesToView: ((CLLocationCoordinate2D) -> Void)?
    var onSuccessFromJSON: (()->Void)?
    var onErrorFromJSON: ((String)->Void)?
    
    //MARK: - INIT
    init(locationUseCase: LocationUseCase, locationService: LocationService) {
        self.locationUseCase = locationUseCase
        self.locationService = locationService
        self.locationService.delegate = self
        getLocations()
    }

    func getLocations() {
        locationUseCase.getLocationsFromJSON(method: .local) { [weak self] errorMsg in
            guard let self = self else { return }
            if let errorMsg = errorMsg {
                self.onErrorFromJSON?(errorMsg)
                return
            }
            self.onSuccessFromJSON?()
        }
    }
    
    func getLocationsFromLocal() {
        self.locations = locationUseCase.getAllLocations()
    }
}

extension DefaultLocationViewModel: LocationServiceProtocol {
    
    func didUpdateLocation(with coordinates: CLLocationCoordinate2D) {
        sendCoordinatesToView?(coordinates)
    }
}
