//
//  AppDelegate.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var coordinator: AppCoordinator?
    
    // MARK: - App Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("App launched")
        
        coordinator = AppCoordinator(services: Services())
        coordinator?.start()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("Opening app via \(url) options: \(options)")

        return true
    }
}
