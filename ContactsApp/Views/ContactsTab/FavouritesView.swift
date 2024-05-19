//
//  FavouritesView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 18/05/2024.
//

import SwiftUI

struct FavouritesView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties

    @EnvironmentObject private var contacts: ContactsData
    
    @State private var showingAddContactView = false
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
            .navigationBarItems(trailing: addButton)
            .fullScreenCover(isPresented: $showingAddContactView) {
                ContactDetailView<ContactsData>(mode: .new(isFavourite: true))
            }
            .fullScreenCover(item: $selectedContact) { contact in
                ContactDetailView<ContactsData>(mode: .display(contact))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
    FavouritesView<ContactsObservableMock>()
        .environmentObject(ContactsObservableMock())
}
