//
//  AppRouter.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 30/10/2022.
//

import UIKit

/// Define every storyboard name here. Start your every storyboard name with capitalized string, otherwise it will crash.
enum Storyboards: String {
    case main = "Main"
    
    /// Generic method to return any viewcontroller subclass
    /// - Parameter identifier: UIViewController subclass
    /// - Returns: Intialized optional object of class
    func instantiateVC<T>(_ identifier: T.Type) -> T?  {
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        guard let viewcontroller = storyboard.instantiateViewController(withIdentifier: String(describing: identifier)) as? T else { return nil}
        return viewcontroller
    }
}


/// App class for navigation.
class AppRouter {
    
    /// Forward navigation type i.e push, present
    enum Navigation {
        case push
        case present
        case modal
        case modalFromBottom
    }
    
    /// Backward navigation type i.e pop, dismiss
    enum BackNavigation {
        case dismiss
        case pop
    }
    
    /// Static function which cast class into object of UINib
    /// i.e let vc:SomeClassController = AppRouter.instantiateViewControllerFromNib()
    /// This will cast vc automatically to SomeClassController
    ///
    /// - Parameter bundle: can be nil which change to default automatically.
    /// - Returns: Intialized object of class.
    static func instantiateViewControllerFromNib<controller: UIViewController>(bundle: Bundle? = nil ) -> controller {
            let viewController = controller(nibName: controller.identifier, bundle: bundle)
            return viewController
    }
}

/// Set of rules for routing forward and backward
protocol Routeable {
    func route(to vc: UIViewController, navigation:AppRouter.Navigation)
    func routeBack(navigation backNavigation:AppRouter.BackNavigation)
    func popToRoot()
}

/// Protocol extension to every UIViewController
extension Routeable where Self:UIViewController {
    
    /// Method to route forward from one viewcontroller to another, this method is available in every UIViewController subclass.
    /// - Parameters:
    ///   - vc: ViewController to which you want to navigate
    ///   - navigation: type of forward navigation i.e push, present, modal
    func route(to vc: UIViewController, navigation:AppRouter.Navigation) {
        switch navigation {
        case .push:
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .present:
            DispatchQueue.main.async {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        case .modal:
            DispatchQueue.main.async {
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .overCurrentContext
                
                self.present(vc, animated: true, completion: nil)
                
            }
        case .modalFromBottom :
            DispatchQueue.main.async {
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    /// Method to route back from current viewcontroller to previous viewcontroller, this method is available in every UIViewController subclass.
    /// - Parameters:
    ///   - vc: ViewController to which you want to navigate
    ///   - navigation: type of backward navigation i.e dismiss, pop
    func routeBack(navigation backNavigation:AppRouter.BackNavigation) {
        switch backNavigation {
        case .dismiss:
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        case .pop:
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /// Method to reset the previous rootViewController and set new rootViewController, this method is available in every UIViewController subclass.
    func setRoot(vc: UINavigationController) {
        guard let application = UIApplication.shared.delegate as? AppDelegate,
              let window = application.window
        else { return }
        window.rootViewController = nil
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {}, completion:
        { completed in
            window.rootViewController = vc
        })

        
    }
    /// Method to navigate directly to rootviewcontroller from any viewcontroller, this method is available in every UIViewController subclass.
    func popToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
