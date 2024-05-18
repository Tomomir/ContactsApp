//
//  FavouriteSwipeAction.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 18/05/2024.
//

import Foundation

import SwiftUI

struct FavouriteSwipeAction<ContactsData: ContactsDataSource>: ViewModifier {
    @ObservedObject var contacts: ContactsData
    
    var contact: Contact
    
    func body(content: Content) -> some View {
        content
            .swipeActions(edge: .leading) {
                Button(action: {
                    contacts.toggleFavourite(contact: contact)
                }) {
                    if contact.isFavourite {
                        Label("UNFAVOURITE", systemImage: "star.slash")
                    } else {
                        Label("FAVOURITE", systemImage: "star")
                    }
                }
                .tint(contact.isFavourite ? .gray : .yellow)
            }
    }
}

extension View {
    func favouriteSwipeActions<ContactsData: ContactsDataSource>(contacts: ContactsData, contact: Contact) -> some View {
        self.modifier(FavouriteSwipeAction(contacts: contacts, contact: contact))
    }
}
