//
//  ContactsView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct ContactsView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties

    @EnvironmentObject private var contacts: ContactsData
    
    @State private var showingAddContactView = false
    @State private var selectedContact: Contact?
    @State private var searchText = ""
    
    private var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return contacts.contacts
        } else {
            return contacts.contacts.filter { contact in
                contact.firstName.localizedCaseInsensitiveContains(searchText) ||
                contact.lastName.localizedCaseInsensitiveContains(searchText) ||
                contact.phoneNumber.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // MARK: - Lifecycle

    var body: some View {
        NavigationView {
            contactsList
            .searchable(text: $searchText)
            .navigationTitle("CONTACTS")
            .navigationBarItems(trailing: addButton)
            .fullScreenCover(item: $selectedContact) { contact in
                ContactDetailView<ContactsData>(mode: .display(contact))
            }
            .fullScreenCover(isPresented: $showingAddContactView) {
                ContactDetailView<ContactsData>(mode: .new(isFavourite: false))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Subviews
    
    private var contactsList: some View {
        List {
            ForEach(filteredContacts) { contact in
                Button(action: {
                    selectedContact = contact
                }) {
                    ContactRowView(contact: contact)
                }
                .favouriteSwipeActions(contacts: contacts, contact: contact)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    let contact = filteredContacts[index]
                    contacts.deleteContact(contact: contact)
                }
            }
        }
    }
    
    // MARK: - Buttons
    
    private var addButton: some View {
        Button(action: {
            showingAddContactView = true
        }) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    ContactsView<ContactsObservableMock>()
        .environmentObject(ContactsObservableMock())
}
