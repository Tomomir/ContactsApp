//
//  ContactsObservable.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation

// MARK: - Protocols

protocol ContactsDataSource: ObservableObject {
    var contacts: [Contact] { get }

    func loadContacts()
    func addContact(firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool)
    func updateContact(contact: Contact, firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool)
    func deleteContact(contact: Contact)
    func toggleFavourite(contact: Contact)
}

class ContactsObservable: ContactsDataSource {
    
    // MARK: - Properties
    
    @Published var contacts: [Contact] = []

    private var coreDataService: CoreDataService
    
    // MARK: - Init
    
    init(coreDataService: CoreDataService) {
        self.coreDataService = coreDataService
        loadContacts()
    }
    
    // MARK: - Methods

    func loadContacts() {
        self.contacts = coreDataService.fetchContacts()
    }

    func addContact(firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool = false) {
        coreDataService.addContact(firstName: firstName,
                                   lastName: lastName,
                                   phoneNumber: phoneNumber,
                                   isFavourite: isFavourite)
        loadContacts() // Reload contacts after adding a new one
    }
    
    func updateContact(contact: Contact, firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool) {
        coreDataService.updateContact(contact: contact,
                                      firstName: firstName,
                                      lastName: lastName,
                                      phoneNumber: phoneNumber,
                                      isFavourite: isFavourite)
        loadContacts() // Reload contacts after updating
    }
    
    func deleteContact(contact: Contact) {
        coreDataService.deleteContact(contact: contact)
        loadContacts() // Reload contacts after deleting
    }

    func toggleFavourite(contact: Contact) {
        updateContact(contact: contact,
                      firstName: contact.firstName,
                      lastName: contact.lastName,
                      phoneNumber: contact.phoneNumber,
                      isFavourite: !contact.isFavourite)
        loadContacts() // Reload contacts after toggling favourite
    }
}

class ContactsObservableMock: ContactsDataSource {
    
    // MARK: - Properties
    
    @Published var contacts: [Contact] = [
        Contact(id: UUID(), firstName: "John", lastName: "Doe", phoneNumber: "123456789", isFavourite: true),
        Contact(id: UUID(), firstName: "Jane", lastName: "Doe", phoneNumber: "987654321", isFavourite: true),
        Contact(id: UUID(), firstName: "Alice", lastName: "Smith", phoneNumber: "111222333", isFavourite: true),
        Contact(id: UUID(), firstName: "Bob", lastName: "Smith", phoneNumber: "333222111", isFavourite: true),
        Contact(id: UUID(), firstName: "Charlie", lastName: "Brown", phoneNumber: "555666777", isFavourite: false),
        Contact(id: UUID(), firstName: "Daisy", lastName: "Brown", phoneNumber: "777666555", isFavourite: false),
        Contact(id: UUID(), firstName: "Eve", lastName: "White", phoneNumber: "888999000", isFavourite: false),
        Contact(id: UUID(), firstName: "Frank", lastName: "Black", phoneNumber: "000999888", isFavourite: false)
    ]
    
    // MARK: - Init
    
    init() {
     
    }
    
    // MARK: - Methods

    func loadContacts() {
        // Do nothing
    }

    func addContact(firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool) {
        // Do nothing
    }

    func updateContact(contact: Contact, firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool) {
        // Do nothing
    }
    
    func deleteContact(contact: Contact) {
        // Do nothing
    }

    func toggleFavourite(contact: Contact) {
        // Do nothing
    }
}
