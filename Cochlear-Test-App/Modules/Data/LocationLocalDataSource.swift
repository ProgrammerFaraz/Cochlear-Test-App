//
//  LocationLocalDataSource.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import Foundation

struct LocationLocalDataSource {
    
    func getLocationsFromJSON(completion: @escaping (Result<LocationModel, Error>) -> ()) {
        if let path = Bundle.main.path(forResource: "locations", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let results = try JSONDecoder().decode(LocationModel.self, from: data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }
    }

}
