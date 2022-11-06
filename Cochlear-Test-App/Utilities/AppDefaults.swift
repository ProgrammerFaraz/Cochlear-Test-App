//
//  AppDefaults.swift
//  Cochlear-Test-App
//
//  Created by Faraz Ahmed Khan on 06/11/2022.
//
import Foundation

class AppDefaults {
    
    public static let defaults = UserDefaults.init()
    
    /// Method to clear all UserDefaults data
    public static func clearUserDefaults(){
        let dictionary = AppDefaults.defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    /// Property to check if the app is not launched for the first time after install
    public static var isNotFirstTime: Bool {
        get {
            return AppDefaults.defaults.bool(forKey: "isNotFirstTime")
        }
        set{
            AppDefaults.defaults.set(newValue, forKey: "isNotFirstTime")
        }
    }
    
}
