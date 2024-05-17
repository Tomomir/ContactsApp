//
//  String.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import Foundation

// MARK: - Extensions

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
