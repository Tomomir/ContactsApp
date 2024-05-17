//
//  Observables.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation

// MARK: - Delegate

protocol AppCoordinatorDelegate: AnyObject {
    func showContactsTabBar()
}

final class Observables {
    
    // MARK: - Properties
    
    private let services: Services
        
    let contacts: ContactsObservable
    
    weak var appCoordinator: AppCoordinatorDelegate?
    
    // MARK: - Init
    
    init(services: Services) {
        self.services = services
        
        contacts = ContactsObservable(coreDataService: services.coreDataService)
    }
}

