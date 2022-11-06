//
//  LocationsDependencyProvider.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import UIKit

/// Dependency resolver for Locations module
struct LocationsDependencyProvider {
    
    /// Resolved Repository
    static var locationRepository: LocationRepository {
        return LocationRepository()
    }
    
    /// Resolved Datasource
    static var locationLocalDatasource: LocationLocalDataSource {
        return LocationLocalDataSource()
    }

    /// Resolved UseCases
    static var locationUseCase: LocationUseCase {
        return DefaultLocationUseCase(locationRepository: locationRepository)
    }

    static var locationService: LocationService {
        return LocationService()
    }
    
    /// Resolved ViewModel
    static var viewModel: DefaultLocationViewModel {
        return DefaultLocationViewModel(locationUseCase: locationUseCase, locationService: locationService)
    }

    /// Resolved ViewController
    static var viewController: LocationsViewController? {
        guard let vc = Storyboards.main.instantiateVC(LocationsViewController.self) else {
            return nil
        }
        vc.viewModel = viewModel
        return vc
    }
    
    /// Resolved NavigationController
    static var navigationController: UINavigationController? {
        guard let vc = self.viewController else {
            return nil
        }
        let navVC = UINavigationController()
        navVC.viewControllers = [vc]
        return navVC
    }

}
