//
//  ValidationTextField.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 28.05.2024.
//

import SwiftUI
import Combine

// MARK: - CUI TextField
struct ValidationTextField: View {
    @Binding var text: String
    var placeholder: String
    var fontColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    ZStack(alignment: .leading) {
                        if text.isEmpty {
                            Text(placeholder)
                                .foregroundColor(.gray)
                                .font(.popRegularCallout)
                                .padding(.leading, 10)
                        }
                        TextField("", text: $text)
                            .foregroundColor(fontColor)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 10)
                    }
                }
            }
        }
        .frame(height: 50)
        .background(Color.white)
        .overlay(RoundedRectangle(cornerRadius: 12).strokeBorder(Color.gray, lineWidth: 1))
    }
}

struct CUINDTextField_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView()
    }
    
    struct PreviewView: View {
        @State private var text = ""
        
        var body: some View {
            ValidationTextField(text: $text,
                                placeholder: "Enter text",
                                fontColor: .black)
            .padding()
        }
    }
}
