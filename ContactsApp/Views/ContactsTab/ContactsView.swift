//
//  ContactsView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

enum ContactsViewMode {
    case all
    case favourites
    
    var title: String {
        switch self {
        case .all:
            return "CONTACTS".localized
        case .favourites:
            return "FAVOURITES".localized
        }
    }
}

struct ContactsView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties

    @EnvironmentObject private var contacts: ContactsData
    
    @State private var showingAddContactView = false
    @State private var selectedContact: Contact?

    private var mode: ContactsViewMode

    // MARK: - Init
    
    init(mode: ContactsViewMode = .all) {
        self.mode = mode
    }
    
    // MARK: - Lifecycle

    var body: some View {
        NavigationView {
            List {
                let contacts = mode == .all ? contacts.contacts : contacts.contacts.filter { $0.isFavourite }
                ForEach(contacts) { contact in
                    Button(action: {
                        selectedContact = contact
                    }) {
                        ContactRowView(contact: contact)
                    }
                }
            }
            .navigationTitle(mode.title)
            .navigationBarItems(trailing: addButton)
            .sheet(item: $selectedContact) { contact in
                ContactDetailView<ContactsData>(mode: .display(contact))
            }
            .sheet(isPresented: $showingAddContactView) {
                ContactDetailView<ContactsData>(mode: .new(isFavourite: mode == .favourites))
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
