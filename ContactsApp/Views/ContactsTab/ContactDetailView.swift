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

    var title: Text {
        switch self {
        case .display:
            return Text("CONTACT_DETAIL")
        case .new(let isFavourite):
            if isFavourite {
                return Text("NEW_FAVOURITE_CONTACT")
            } else {
                return Text("NEW_CONTACT")
            }
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
    @State private var isEditing: Bool = false
    
    @FocusState private var focusedField: Field?

    private enum Field: Hashable {
        case firstName, lastName, phoneNumber
    }
    
    private var isFormValid: Bool {
        return !firstName.isEmpty || !lastName.isEmpty
    }
    
    private var isDisplayMode: Bool {
        if case .display = mode {
            return true
        }
        return false
    }
    
    // MARK: - Init
    
    init(mode: ContactDetailViewMode) {
        self.mode = mode
        
        switch mode {
        case .new(let isFavourite):
            _firstName = State(initialValue: "")
            _lastName = State(initialValue: "")
            _phoneNumber = State(initialValue: "")
            _isFavourite = State(initialValue: isFavourite)
        case .display(let contact):
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
                .navigationBarItems(leading: leadingButton, trailing: trailingButton)
        }
    }
    
    // MARK: - Subviews

    private var content: some View {
        Form {
            Section {
                TextField("FIRST_NAME", text: $firstName)
                    .disabled(isDisplayMode && !isEditing)
                    .textContentType(.givenName)
                    .focused($focusedField, equals: .firstName)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .lastName
                    }
                TextField("LAST_NAME", text: $lastName)
                    .disabled(isDisplayMode && !isEditing)
                    .textContentType(.familyName)
                    .focused($focusedField, equals: .lastName)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .phoneNumber
                    }
                TextField("PHONE_NUMBER", text: $phoneNumber)
                    .disabled(isDisplayMode && !isEditing)
                    .textContentType(.telephoneNumber)
                    .focused($focusedField, equals: .phoneNumber)
                    .keyboardType(.phonePad)
                    .autocorrectionDisabled()
            }
            
            if isDisplayMode && isEditing {
                Section {
                    deleteButton
                }
            }
        }
    }
    
    // MARK: - Buttons
    
    private var leadingButton: some View {
        Button(action: {
            if isEditing {
                // Cancel edit
                if case .display(let contact) = mode {
                    firstName = contact.firstName
                    lastName = contact.lastName
                    phoneNumber = contact.phoneNumber
                    isFavourite = contact.isFavourite
                }
                isEditing.toggle()
            } else {
                presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text(isEditing ? "CANCEL" : "CLOSE")
        }
    }
    
    private var trailingButton: some View {
        switch mode {
        case .display:
            return Button(action: {
                if isEditing {
                    contacts.updateContact(contact: contact!,
                                           firstName: firstName,
                                           lastName: lastName,
                                           phoneNumber: phoneNumber,
                                           isFavourite: isFavourite)
                }
                isEditing.toggle()
            }) {
                Text(isEditing ? "DONE" : "EDIT")
            }
            .disabled(isEditing && !isFormValid)
        case .new:
            return Button(action: {
                contacts.addContact(firstName: firstName,
                                    lastName: lastName,
                                    phoneNumber: phoneNumber,
                                    isFavourite: isFavourite)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("SAVE")
            }
            .disabled(!isFormValid)
        }
    }
    
    private var deleteButton: some View {
        Button(action: {
            contacts.deleteContact(contact: contact!)
            presentationMode.wrappedValue.dismiss()
        }) {
            Text("DELETE_CONTACT")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    ContactDetailView<ContactsObservableMock>(mode: .display(Contact.mockedContact))
        .environmentObject(ContactsObservableMock())
}
