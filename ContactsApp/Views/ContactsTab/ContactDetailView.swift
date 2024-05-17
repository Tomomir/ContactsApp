//
//  ContactDetailView.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

// MARK: - Enums

enum ContactDetailViewMode {
    case display(Contact)
    case new(isFavourite: Bool)
    case edit(Contact)

    var title: String {
        switch self {
        case .display:
            return "CONTACT_DETAIL"
        case .new(let isFavourite):
            if isFavourite {
                return "NEW_FAVOURITE_CONTACT"
            } else {
                return "NEW_CONTACT"
            }
        case .edit:
            return "EDIT_CONTACT"
        }
    }
}

struct ContactDetailView<ContactsData: ContactsDataSource>: View {
    
    // MARK: - Properties
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var contacts: ContactsData
    
    private var mode: ContactDetailViewMode
    private var contact: Contact?
    
    @State private var firstName: String
    @State private var lastName: String
    @State private var phoneNumber: String
    @State private var isFavourite: Bool
    
    // MARK: - Init
    
    init(mode: ContactDetailViewMode) {
        self.mode = mode
        
        switch mode {
        case .new(let isFavourite):
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
            _phoneNumber = State(initialValue: "")
            _isFavourite = State(initialValue: isFavourite)
        case .edit(let contact), .display(let contact):
            self.contact = contact
            _firstName = State(initialValue: contact.firstName)
            _lastName = State(initialValue: contact.lastName)
            _phoneNumber = State(initialValue: contact.phoneNumber)
            _isFavourite = State(initialValue: contact.isFavourite)
        }
    }
    
    // MARK: - Lifecycle
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitle(mode.title, displayMode: .inline)
                .navigationBarItems(leading: closeButton)
        }
    }
    
    // MARK: - Subviews

    private var content: some View {
        Form {
            Section(header: Text("CONTACT_DETAILS")) {
                FloatingLabelTextField(text: $firstName, placeholder: "FIRST_NAME")
                FloatingLabelTextField(text: $lastName, placeholder: "LAST_NAME")
                FloatingLabelTextField(text: $phoneNumber, placeholder: "PHONE_NUMBER")
            }
            
            if contact != nil {
                Section {
                    Button(action: {
                        // Handle delete action here
                        
                    }) {
                        Text("DELETE_CONTACT")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
    
    // MARK: - Buttons
    
    private var closeButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("CLOSE")
        }
    }
}

#Preview {
    ContactDetailView<ContactsObservableMock>(mode: .display(Contact.mockedContact))
}
