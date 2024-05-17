//
//  AppCoordinator.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation

import UIKit
import SwiftUI

final class AppCoordinator {

    // MARK: - Properties

    let window: UIWindow?
    private let observableObjects: Observables
    
    private var contactsTabBarView: some View {
        ContactsTabBarView<ContactsObservable>()
            .inject(objects: observableObjects)
    }
    
    // MARK: - Init

    init(services: Services) {
        observableObjects = Observables(services: services)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
    }

    // MARK: - Lifecycle

    func start() {
        showContactsTabBar()
    }
    
    func show(controller: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = controller
        UIView.transition(with: window, duration: 0.2,options: .transitionCrossDissolve, animations: nil)
    }
}

// MARK: - Extensions

extension AppCoordinator: AppCoordinatorDelegate {
    func showContactsTabBar() {
        let vc = UIHostingController(rootView: contactsTabBarView)
        show(controller: vc)
    }
}
