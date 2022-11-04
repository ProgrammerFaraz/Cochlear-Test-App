//
//  LocationRepository.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import Foundation

class LocationRepository {
    
    //MARK: - PROPERTIES
    private var localDataSource: LocationLocalDataSource!
    
    //MARK: - INIT
    init() {
        localDataSource = LocationLocalDataSource()
    }
    
    //MARK: - METHODS
    func getLocationsFromJSON(from method: FetchingType, completion:@escaping (LocationModel?, String?) -> ()) {
        switch method {
        case .local:
            localDataSource.getLocationsFromJSON { result in
                switch result {
                case .success(let response):
                    completion(response, nil)
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }
        case .remote:
            //Add loading from local DB logic here
            print("Loading from local DB here")
        }
    }
}
