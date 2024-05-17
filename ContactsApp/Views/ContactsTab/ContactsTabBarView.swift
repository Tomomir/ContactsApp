//
//  ContactsTabBarView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct ContactsTabBarView: View {
    
    // MARK: - Properties
        
    // MARK: - Lifecycle
    
    var body: some View {
        TabView {
            ContactsView()
                .tabItem {
                    Label("CONTACTS", systemImage: "person.3.fill")
                }
            
            FavouritesView()
                .tabItem {
                    Label("FAVOURITES", systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    ContactsTabBarView()
}

