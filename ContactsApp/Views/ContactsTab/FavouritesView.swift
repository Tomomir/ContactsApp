//
//  FavouritesView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct FavouritesView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties

    @EnvironmentObject private var contacts: ContactsData
    @State private var selectedContact: Contact?

    // MARK: - Lifecycle
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts.contacts.filter { $0.isFavourite }) { contact in
                    Button(action: {
                        selectedContact = contact
                    }) {
                        ContactRowView(contact: contact)
                    }
                }
            }
            .navigationTitle("FAVOURITES")
        }
    }
}

#Preview {
    FavouritesView<ContactsObservableMock>()
        .environmentObject(ContactsObservableMock())
}
