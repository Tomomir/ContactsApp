//
//  ContactRowView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct ContactRowView: View {
    
    // MARK: - Properties
    
    let contact: Contact

    // MARK: - Lifecycle
    
    var body: some View {
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

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContactRowView(contact: Contact.mockedContact)
            ContactRowView(contact: Contact.mockedContact)
        }
        .previewLayout(.sizeThatFits)
    }
}
