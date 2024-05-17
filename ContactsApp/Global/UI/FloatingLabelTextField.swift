//
//  FloatingLabelTextField.swift
//  ContactsApp
//
//  Created by Tomas Pecuch on 17/05/2024.
//

import SwiftUI

struct FloatingLabelTextField: View {
    
    // MARK: - Properties
    
    @Binding var text: String
    var placeholder: String
    
    @State private var isFocused: Bool = false

    // MARK: - Lifecycle
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(isFocused || !text.isEmpty ? Color(UIColor.systemGray) : Color(UIColor.label))
                .offset(y: isFocused || !text.isEmpty ? -20 : 0)
                .scaleEffect(isFocused || !text.isEmpty ? 0.75 : 1.0, anchor: .leading)
                .animation(.easeInOut(duration: 0.2), value: isFocused || !text.isEmpty)
            
            TextField("", text: $text, onEditingChanged: { editing in
                withAnimation(.easeInOut(duration: 0.2)) {
                    isFocused = editing
                }
            })
                .padding(.top, isFocused || !text.isEmpty ? 20 : 0)
        }
        .padding(.top, 15)
    }
}
