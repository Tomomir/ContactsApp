//
//  ContactsTabBarView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct ContactsTabBarView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var contacts: ContactsData
    
    // MARK: - Lifecycle
    
    var body: some View {
        TabView {
            ContactsView<ContactsData>()
                .tabItem {
                    Label("CONTACTS", systemImage: "person.3.fill")
                }
            
            FavouritesView<ContactsData>()
                .tabItem {
                    Label("FAVOURITES", systemImage: "star.fill")
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }
}

#Preview {
    ContactsTabBarView<ContactsObservableMock>()
        .environmentObject(ContactsObservableMock())
}

