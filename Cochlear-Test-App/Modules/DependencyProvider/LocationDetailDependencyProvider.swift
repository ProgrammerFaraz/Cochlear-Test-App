//
//  LocationDetailDependencyProvider.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 05/11/2022.
//

import UIKit

/// Dependency resolver for Location Detail module
struct LocationDetailDependencyProvider {
    
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
    
    /// Resolved ViewModel
    static var viewModel: DefaultLocationDetailViewModel {
        return DefaultLocationDetailViewModel(locationUseCase: locationUseCase)
    }

    /// Resolved ViewController
    static var viewController: LocationDetailViewController? {
        guard let vc = Storyboards.main.instantiateVC(LocationDetailViewController.self) else {
            return nil
        }
        vc.viewModel = viewModel
        return vc
    }

}
