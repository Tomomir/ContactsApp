//
//  EnviromentViewModifier.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation
import SwiftUI

private struct EnvironmentViewModifier: ViewModifier {
    
    // MARK: - Properties
    
    let objects: Observables

    // MARK: - Lifecycle
    
    func body(content: Content) -> some View {
        content
            .environmentObject(objects.contacts)
    }
}

// MARK: - Extensions

extension View {
    func inject(objects: Observables) -> some View {
        modifier(EnvironmentViewModifier(objects: objects))
    }
}
