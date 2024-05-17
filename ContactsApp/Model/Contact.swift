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

// MARK: - Extensions

extension Contact {
    static var mockedContact: Contact {
        return Contact(id: UUID(), firstName: "John", lastName: "Doe", phoneNumber: "123456789", isFavourite: true)
    }
}
