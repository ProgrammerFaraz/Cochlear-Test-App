//
//  LocationsViewController.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 29/10/2022.
//

import UIKit
import MapKit

class LocationsViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - VARIABLES
    var viewModel: DefaultLocationViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.getLocations()
        
    }
    
    private func bindViewModel() {
        
        viewModel?.onSuccessFromJSON = { [weak self] in
            self?.addAnnotation(locations: self?.viewModel?.locations)
        }
        
        viewModel?.onErrorFromJSON = { [weak self] error in
            print("Deal with error here: \(error)")
            self?.viewModel?.locationService.setupLocation()
        }
        
        viewModel?.sendCoordinatesToView = { [weak self] coordinates in
            self?.setRegion(coordinates: coordinates)
        }
    }
    
    private func setupLocations() {
        mapView.showsUserLocation = true
    }
    
    private func addAnnotation(locations: [Location]?) {
        guard let locations = locations else {
            return
        }
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location.lat, location.lng)
            annotation.title = location.name
            self.mapView.addAnnotation(annotation)
        }
        setRegion(coordinates: CLLocationCoordinate2D(latitude: locations.last?.lat ?? 0.0, longitude: locations.last?.lng ?? 0.0))
    }
    
    private func setRegion(coordinates: CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        self.mapView.setRegion(viewRegion, animated: true)
    }
}

extension LocationsViewController: MKMapViewDelegate {
    
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.locations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier) as? LocationTableViewCell else { return UITableViewCell() }
        cell.configure(location: viewModel?.locations[indexPath.row].name ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        setRegion(coordinates: CLLocationCoordinate2D(latitude: viewModel.locations[indexPath.row].lat, longitude: viewModel.locations[indexPath.row].lng))
    }
}
