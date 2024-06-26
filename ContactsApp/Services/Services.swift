//
//  Services.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation

final class Services {
    
    // MARK: - Properties
        
    let coreDataService: CoreDataService

    // MARK: - Lifecycle
    
    init() {
        coreDataService = CoreDataService()
    }
}
