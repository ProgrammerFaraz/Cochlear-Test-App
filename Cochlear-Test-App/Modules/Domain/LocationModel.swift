//
//  LocationModel.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import Foundation

struct LocationModel: Codable {
    let locations: [Location]
    let updated: String
}

struct Location: Codable {
    let name: String
    let lat, lng: Double
}
