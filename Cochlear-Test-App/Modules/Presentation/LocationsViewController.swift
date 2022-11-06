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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateLocations()
    }
    
    private func bindViewModel() {
        
        viewModel?.onSuccessFromJSON = { [weak self] in
            guard let self = self else { return }
            self.updateLocations()
        }
        
        viewModel?.onErrorFromJSON = { [weak self] error in
            print("Deal with error here: \(error)")
            self?.viewModel?.locationService.setupLocation()
        }
        
        viewModel?.sendCoordinatesToView = { [weak self] coordinates in
            self?.setRegion(coordinates: coordinates)
        }
    }
    
    private func updateLocations() {
        self.viewModel?.getLocationsFromLocal()
        self.tableView.reloadData()
        self.addAnnotation(locations: self.viewModel?.locations)
    }
    
    private func addAnnotation(locations: [RealmLocationModel]?) {
        guard let locations = locations else {
            return
        }
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(Double(location.latitude ?? "") ?? 0.0, Double(location.longitude ?? "") ?? 0.0)
            annotation.title = location.locationName
            annotation.subtitle = location.notes
            self.mapView.addAnnotation(annotation)
        }
        setRegion(coordinates: CLLocationCoordinate2D(latitude: Double(locations.last?.latitude ?? "") ?? 0.0, longitude: Double(locations.last?.longitude ?? "") ?? 0.0))
    }
    
    private func setRegion(coordinates: CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
    private func navigateToDetailScreen(location: Location) {
        if let vc = LocationDetailDependencyProvider.viewController {
            vc.location = location
            self.route(to: vc, navigation: .push)
        }
    }
}

extension LocationsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        navigateToDetailScreen(location: Location(name: (view.annotation?.title ?? "") ?? "", lat: view.annotation?.coordinate.latitude ?? 0.0, lng: view.annotation?.coordinate.longitude ?? 0.0))
    }
}

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.locations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier) as? LocationTableViewCell else { return UITableViewCell() }
        cell.configure(location: viewModel?.locations[indexPath.row].locationName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        setRegion(coordinates: CLLocationCoordinate2D(latitude: Double(viewModel.locations[indexPath.row].latitude ?? "0.0") ?? 0.0, longitude: Double(viewModel.locations[indexPath.row].longitude ?? "0.0") ?? 0.0))
        navigateToDetailScreen(location: Location(name: viewModel.locations[indexPath.row].locationName ?? "", lat: Double(viewModel.locations[indexPath.row].latitude ?? "0.0") ?? 0.0, lng: Double(viewModel.locations[indexPath.row].longitude ?? "0.0") ?? 0.0))
    }
}
