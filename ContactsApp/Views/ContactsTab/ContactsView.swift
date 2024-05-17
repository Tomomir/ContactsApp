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
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContactsView<ContactsObservableMock>()
        .environmentObject(ContactsObservableMock())
}
