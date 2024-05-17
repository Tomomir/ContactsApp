//
//  ContactsView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct ContactsView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties

    @EnvironmentObject var contacts: ContactsData

    @State private var selectedContact: Contact?

    // MARK: - Lifecycle

    var body: some View {
        NavigationView {
            List {
                ForEach(contacts.contacts) { contact in
                    Button(action: {
                        selectedContact = contact
                    }) {
                        HStack {
                            Text("\(contact.firstName) \(contact.lastName)")
                                .foregroundColor(.primary)
                            Spacer()
                            if contact.isFavourite {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        .padding(.vertical, 6)
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
