//
//  CoreDataService.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation
import Foundation
import CoreData
import SwiftUI

class CoreDataService {
    
    // MARK: - Properties
    
    let persistentContainer: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Init
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ContactsDataModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    // MARK: - Methods
    
    func fetchContacts() -> [Contact] {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        do {
            let entities = try context.fetch(fetchRequest)
            return entities.map { entity in
                Contact(
                    id: entity.id ?? UUID(),
                    firstName: entity.firstName ?? "",
                    lastName: entity.lastName ?? "",
                    phoneNumber: entity.phoneNumber ?? "",
                    isFavourite: entity.isFavourite
                )
            }
        } catch {
            print("Error fetching contacts: \(error)")
            return []
        }
    }

    func addContact(firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool) {
        let newContact = ContactEntity(context: context)
        newContact.id = UUID()
        newContact.firstName = firstName
        newContact.lastName = lastName
        newContact.phoneNumber = phoneNumber
        newContact.isFavourite = isFavourite
        saveContext()
    }
    
    func updateContact(contact: Contact, firstName: String, lastName: String, phoneNumber: String, isFavourite: Bool) {
        if let contactEntity = fetchContactEntiy(contact: contact) {
            contactEntity.firstName = firstName
            contactEntity.lastName = lastName
            contactEntity.phoneNumber = phoneNumber
            contactEntity.isFavourite = isFavourite
            saveContext()
        }
    }
    
    func deleteContact(contact: Contact) {
        if let contactEntity = fetchContactEntiy(contact: contact) {
            context.delete(contactEntity)
            saveContext()
        }
    }
    
    // MARK: - Helper methods

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    private func fetchContactEntiy(contact: Contact) -> ContactEntity? {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", contact.id as CVarArg)
        
        do {
            let fetchedContacts = try context.fetch(fetchRequest)
            return fetchedContacts.first
        } catch {
            print("Error fetching contact: \(error)")
            return nil
        }
    }
}
