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
    
    // MARK: - Lifecycle

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts.contacts) { contact in
                    Button(action: {
                        selectedContact = contact
                    }) {
                        ContactRowView(contact: contact)
                    }
                }
            }
            .navigationTitle("CONTACTS")
            .navigationBarItems(trailing: addButton)
            .sheet(item: $selectedContact) { contact in
                ContactDetailView<ContactsData>(mode: .display(contact))
            }
            .sheet(isPresented: $showingAddContactView) {
                ContactDetailView<ContactsData>(mode: .new(isFavourite: false))
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
