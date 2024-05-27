//
//  ContactsObservableTests.swift
//  ContactsAppTests
//
//  Created by Tomas Pecuch on 27/05/2024.
//

import XCTest
import Combine
import CoreData
@testable import ContactsApp

class ContactsObservableTests: XCTestCase {
    
    // MARK: - Properties
    
    var coreDataServiceMock: CoreDataServiceMock!
    var contactsObservable: ContactsObservable!
    var cancellables: Set<AnyCancellable>!

    // MARK: - Lifecycle
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        coreDataServiceMock = CoreDataServiceMock(persistentContainer: NSPersistentContainer(name: "ContactsDataModel"))
        contactsObservable = ContactsObservable(coreDataService: coreDataServiceMock)
        cancellables = []
    }

    override func tearDownWithError() throws {
        contactsObservable = nil
        coreDataServiceMock = nil
        cancellables = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Tests

    func testLoadContacts() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Contacts loaded")
        coreDataServiceMock.contacts = [
            Contact(id: UUID(), firstName: "John", lastName: "Doe", phoneNumber: "1234567890", isFavourite: false)
        ]
        
        // Act
        contactsObservable.loadContacts()
        
        // Assert
        contactsObservable.$contacts
            .sink { contacts in
                XCTAssertEqual(contacts.count, 1)
                XCTAssertEqual(contacts.first?.firstName, "John")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testAddContact() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Contact added")
        
        // Act
        contactsObservable.addContact(firstName: "Jane", lastName: "Doe", phoneNumber: "0987654321", isFavourite: true)
        
        // Assert
        contactsObservable.$contacts
            .sink { contacts in
                XCTAssertEqual(contacts.count, 1)
                XCTAssertEqual(contacts.first?.firstName, "Jane")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testUpdateContact() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Contact updated")
        let contact = Contact(id: UUID(), firstName: "John", lastName: "Doe", phoneNumber: "1234567890", isFavourite: false)
        coreDataServiceMock.contacts = [contact]
        
        // Act
        contactsObservable.updateContact(contact: contact, firstName: "Jane", lastName: "Doe", phoneNumber: "0987654321", isFavourite: true)
        
        // Assert
        contactsObservable.$contacts
            .sink { contacts in
                XCTAssertEqual(contacts.count, 1)
                XCTAssertEqual(contacts.first?.firstName, "Jane")
                XCTAssertEqual(contacts.first?.isFavourite, true)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testDeleteContact() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Contact deleted")
        let contact = Contact(id: UUID(), firstName: "John", lastName: "Doe", phoneNumber: "1234567890", isFavourite: false)
        coreDataServiceMock.contacts = [contact]
        
        // Act
        contactsObservable.deleteContact(contact: contact)
        
        // Assert
        contactsObservable.$contacts
            .sink { contacts in
                XCTAssertEqual(contacts.count, 0)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testToggleFavourite() throws {
        // Arrange
        let expectation = XCTestExpectation(description: "Favourite toggled")
        let contact = Contact(id: UUID(), firstName: "John", lastName: "Doe", phoneNumber: "1234567890", isFavourite: false)
        coreDataServiceMock.contacts = [contact]
        
        // Act
        contactsObservable.toggleFavourite(contact: contact)
        
        // Assert
        contactsObservable.$contacts
            .sink { contacts in
                XCTAssertEqual(contacts.count, 1)
                XCTAssertEqual(contacts.first?.isFavourite, true)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}
