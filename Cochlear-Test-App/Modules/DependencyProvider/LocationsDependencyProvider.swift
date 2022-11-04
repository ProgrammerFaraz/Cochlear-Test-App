//
//  MapVCDependencyProvider.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import UIKit

/// Dependency resolver for MapVC module
struct MapVCDependencyProvider {
    
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
    static var viewController: UIViewController {
        guard let vc = Storyboards.main.instantiateVC(LocationsViewController.self) else {
            return UIViewController()
        }
        vc.viewModel = viewModel
        return vc
    }
    
    /// Resolved NavigationController
    static var navigationController: UINavigationController {
        let navVC = UINavigationController()
        navVC.viewControllers = [self.viewController]
        return navVC
    }

}
