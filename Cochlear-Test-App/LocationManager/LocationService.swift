//
//  LocationService.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import CoreLocation

protocol LocationServiceProtocol {
    func didUpdateLocation(with coordinates: CLLocationCoordinate2D)
}

class LocationService: NSObject {
    
    private var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    var delegate: LocationServiceProtocol?
    
    override init() {
        super.init()
//        setupLocation()
    }
    
    func setupLocation() {
    
        locationManager.delegate = self
        print("locationManager.delegate: ", locationManager.delegate)

        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        // Check for Location Services
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            startUpdatingLocation()
        }
        
    }
    
    private func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func getLocation(with coordinated: [CLLocationCoordinate2D]) {
        
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer { currentLocation = locations.last }
        
        if currentLocation == nil {
            // Zoom to user location
            if let userLocation = locations.last {
                delegate?.didUpdateLocation(with: userLocation.coordinate)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("\(error.localizedDescription)")
   }

}
