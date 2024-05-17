//
//  Contact.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation

struct Contact: Identifiable {
    
    // MARK: - Properties
    
    let id: UUID
    
    let firstName: String
    let lastName: String
    let phoneNumber: String
    
    var isFavourite: Bool
}
