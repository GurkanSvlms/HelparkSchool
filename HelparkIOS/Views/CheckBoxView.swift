//
//  CheckBoxView.swift
//  HelparkIOS
//
//  Created by Ali Gürkan Sevilmis on 31.05.2024.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isMarked: Bool
    @Binding var docText: String
    @State var openDoc = false
    @State var forRegister: Bool = false
    @State var clickAction: (() -> Void)? = nil
    
    var body: some View {
        NavigationLink(destination: AgreementView(
            agreementMarked: $isMarked,
            forRegister: $forRegister),
                       isActive: $openDoc) { EmptyView() }
        HStack(alignment: .top){
            HStack(alignment: .top, spacing: 8) {
                Image(self.isMarked ? "checkbox_filled" : "checkbox_empty")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                
            }
            
            Button(action: {
                openDoc = true
            }) {
                Text("Helpark San. ve Tic A.Ş.nin taradıma \(docText) ile ticeri elektronik ileti göndermesine belirtilen izni veriyorum.")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(width: 330)
                    .multilineTextAlignment(.leading)
            }
        }
        
    }
}

#Preview {
    CheckBoxView(isMarked: .constant(false), docText: .constant("SMS"))
}
